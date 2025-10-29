Return-Path: <netdev+bounces-234084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E6DC1C678
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 18:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D3A35846E1
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 17:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF0933F39D;
	Wed, 29 Oct 2025 17:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Acxm15kt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C14239573;
	Wed, 29 Oct 2025 17:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761757201; cv=none; b=tlUtkTDFuCL+2MxF7BUfBqyioXWa86USeZFoVgFOCWfXENMONY02djYZw5eXv6MCMSVovQKWj3hlr0oWaQA4gLebVVmHafFls7Ce0KXvzvr0xOnRMyV3IVJrX+uHzHPUMpeA3EmUPdiQNwdXSUAdfqcRUQleOzU/ktV06Ri+tmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761757201; c=relaxed/simple;
	bh=HvrJnfTPdaNqtwSgq6WbH6vY0VW6uUPh2Z0MmsIdzmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QjWA7wS8suv9OCQTFF8aIMl0OGYZY2a3r3nkd80zUH4F7i1cMt0UpigSy7X2IwRJhcpn5bANA5uVEDb6t+q57gcGtsrFjPRXXgz8XHzqqq/Y0dZT7H/eTRt4vwuJShevcbW5urrXZFkxhaTopokK41G0gVoInSd/yWiLsAFRhEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Acxm15kt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07ABBC4CEF7;
	Wed, 29 Oct 2025 16:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761757200;
	bh=HvrJnfTPdaNqtwSgq6WbH6vY0VW6uUPh2Z0MmsIdzmo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Acxm15ktlNKvc3SMEKvqhA30xNYFygbEQKdSFRa2RAFoJEZ9FDhLdF7Q5BJve5/+I
	 HIvFpfwptKNFXVYP840zt34VqcBS+ohDMJxTH+wym7w06+2fhe4td8HQecSLjZMVmZ
	 HLFXAxbacZsXhZgiWsTDbyN2o71effTWPDo7H8dBQW60Btmp2sdRWHZVZL+i/w5V5F
	 HG2DxJZQ7U59/Yh5INwbJXlXdd+nrW8m/d11Cwnt42XrzYNzKEHYghPUYbfks/sdVr
	 Tr2a+YM8ur1mFj4mi6TCR2c8dE5o+YmTDdai0oH6sKFWOXDnTglYtknXqFvWfw53f1
	 6vax4/30a6gsQ==
Date: Wed, 29 Oct 2025 16:59:56 +0000
From: Simon Horman <horms@kernel.org>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 08/12] selftests/vsock: identify and execute
 tests that can re-use VM
Message-ID: <aQJIDNt6hCXvfPsH@horms.kernel.org>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
 <20251022-vsock-selftests-fixes-and-improvements-v1-8-edeb179d6463@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022-vsock-selftests-fixes-and-improvements-v1-8-edeb179d6463@meta.com>

On Wed, Oct 22, 2025 at 06:00:12PM -0700, Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> In preparation for future patches that introduce tests that cannot
> re-use the same VM, add functions to identify those that *can* re-use a
> VM.
> 
> By continuing to re-use the same VM for these tests we can save time by
> avoiding the delay of booting a VM for every test.
> 
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Reviewed-by: Simon Horman <horms@kernel.org>


