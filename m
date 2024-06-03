Return-Path: <netdev+bounces-100405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCA28FA6B0
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 01:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C793C1C2220F
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 23:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8DE13B5B7;
	Mon,  3 Jun 2024 23:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qV4fpDT2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3777D3BB24
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 23:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717459172; cv=none; b=dQn+bFKc5vGtblehD5z5R3Jf7EDbNo7OH/hYzHuOarwZYRO8k9VpFPWbbyyoALYlKFC+Mp+Zm81oL3EwDJdP1jVsP4E3sogQt5G1UditSU11HZrsMtHBV+O9CcfGQL4f4LkvdDY9xvPai3XOOwBFizJFkTpl2Y0+8f11JHFMcAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717459172; c=relaxed/simple;
	bh=nGuV+/cY4yftgbgU9V6Az8zBTq9WVMkMFDggJ4nBCNk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X7tFqDQE/cLpceEqcblmAlnTwuXUjMLTlDkr/imlpugwsBheoXAn9urIAqjR/w9dTjLRXu4pd5pUf7Srpw1w/6ZIKCOmjWEXCwAYXuGqgzp9Qrm51P243arDItMtT9Fb58ebbCXYJLWIAZGuCxWUR5eOLZYMiGc329egYt5uaTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qV4fpDT2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910D9C32781;
	Mon,  3 Jun 2024 23:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717459171;
	bh=nGuV+/cY4yftgbgU9V6Az8zBTq9WVMkMFDggJ4nBCNk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qV4fpDT2lqymxaZFSN5KaBHYiuQfQryyjfus/HOD7YWZxXc+u2TjVlAcNnQj9CY12
	 iGlPKhLJqQFgNerOMJn3PuaWLV6ujLsJRUhuuhfC4OCCo8sr1SnUnWXzvzfDBqKmMh
	 n1fwFsneo3FNia9/H3FlP49Vc0MjwPmyNxGB3R8VFKW6CG58IdHBu1jaDcg4GuBmOU
	 FuzMK8a63hxVEKjp37DFIlDHzocd4e4s/lVOJF0/51BbxGWPG2Ed4HSZa3VZN20OJ3
	 DmP2m4dpjW6UX49K87PtFgglgkIt2WUlkuN6Xt8M7R9k5F5Hu8g+EAbqwYRxKya1kY
	 lwB1+uFRb8Tuw==
Date: Mon, 3 Jun 2024 16:59:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ronak Doshi <ronak.doshi@broadcom.com>
Cc: Matthias Stocker <mstocker@barracuda.com>, doshir@vmware.com,
 pv-drivers@vmware.com, netdev@vger.kernel.org
Subject: Re: [PATCH v2] vmxnet3: disable rx data ring on dma allocation
 failure
Message-ID: <20240603165930.4a640f23@kernel.org>
In-Reply-To: <CAP1Q3XSvz60Lo10j7RUJR7qmFLv=cMMkaN_EZ1q2YuP1VE6xxw@mail.gmail.com>
References: <20240531103711.101961-1-mstocker@barracuda.com>
	<CAP1Q3XSvz60Lo10j7RUJR7qmFLv=cMMkaN_EZ1q2YuP1VE6xxw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 2 Jun 2024 23:49:48 -0700 Ronak Doshi wrote:
> Reviewed-by: Ronak Doshi <ronak.doshi@broadcom.com>

Thanks!

> This electronic communication and the information and any files transmitted 
> with it, or attached to it, are confidential and are intended solely for 
> the use of the individual or entity to whom it is addressed and may contain 
> information that is confidential, legally privileged, protected by privacy 
> laws, or otherwise restricted from disclosure to anyone else. If you are 
> not the intended recipient or the person responsible for delivering the 
> e-mail to the intended recipient, you are hereby notified that any use, 
> copying, distributing, dissemination, forwarding, printing, or copying of 
> this e-mail is strictly prohibited. If you received this e-mail in error, 
> please return the e-mail to the sender, delete it from your computer, and 
> destroy any printed copy of it.

Please get rid of this footer. NIC folks (Andy Gospodarek and Michael
Chan) within Broadcom may know some tricks.

