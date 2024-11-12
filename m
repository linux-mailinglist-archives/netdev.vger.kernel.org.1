Return-Path: <netdev+bounces-143944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB77D9C4CE3
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 03:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 914482822EE
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 02:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFCC1F8195;
	Tue, 12 Nov 2024 02:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQdmgFsr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8727819EEA1
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 02:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731380079; cv=none; b=aZzMjvtIok0U2NwgNYEkckzcEaGprN3IPzJIPRnkyK9oJYOcCAuw5dpONCq1pJ/3AbI2NyxJ92nph/NoqQTMINMwfLjxVTSzFAHMyoIUFaIRJCgYdzwbSji5gaIn/QmPBO5PVNJ+9dHbUAFYokbLVM3XszxdSCiP9LSjW+b6j2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731380079; c=relaxed/simple;
	bh=fKvkOW5obKyEkLch/Ywu+tcnCH42bpbkxKiPvcAZDJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tikkgqtcd/p6JO9xe0m8KQnGVh9G+rBcwKP9aUwZVYuldYhynNoVGLhi1LIg82c+/7Kh39I+lFQQSOPSlcVnJW8ymhSXwJ/i4hI91DkFkqKQwhJ4PFD5rxmPw+UTE5ryqqMlekKD33/6GaVsMNwmDPjmlEdIP6UkElH58XhUpLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQdmgFsr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0960C4CECF;
	Tue, 12 Nov 2024 02:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731380079;
	bh=fKvkOW5obKyEkLch/Ywu+tcnCH42bpbkxKiPvcAZDJ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FQdmgFsrE1/D8C0C1jk1P076+3lKg1RGjTi11j8WJNjh9BLcYpbgPyO8Lm87C4CUw
	 fV+VeNo8eNrS0Je+YEsp0gMPw7jhLjkr1y0LDJOB7xaPQw+c5Ok+Om+fOa+A4t9dKx
	 7UoXxF7Xu5JNw5EBP6NejUsFfZ6g8TN/fdXYbDF0M80RavQmI93YOnFTROuFnyIdYE
	 FwlJhQ1JvPPGqgVdwy0hLtdu98VNx3BSqEcgcnJnsdWYkPdqRETQlPHHwIDX2mgADL
	 cu8gYQeFxzALNgu0AhAuVmQolnU0g5UI9ZHSQcuPPo+RtIaL3iWI6RuGX7tCOLmnIr
	 tb4Q03uFgVBxw==
Date: Mon, 11 Nov 2024 18:54:38 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, Sudheer
 Mogilappagari <sudheer.mogilappagari@intel.com>
Subject: Re: [PATCH iwl-net 2/2] idpf: finish pending IRQ handling before
 freeing interrupt
Message-ID: <20241111185438.319bbb79@kernel.org>
In-Reply-To: <20241109001206.213581-3-ahmed.zaki@intel.com>
References: <20241109001206.213581-1-ahmed.zaki@intel.com>
	<20241109001206.213581-3-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  8 Nov 2024 17:12:06 -0700 Ahmed Zaki wrote:
> From: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
> 
> Wait for pending IRQs to be handled before an interrupt is free'd up.

read the kdoc on free_irq(), please

