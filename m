Return-Path: <netdev+bounces-176476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0A5A6A798
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 14:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5D4B98348D
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 13:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA36221F39;
	Thu, 20 Mar 2025 13:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5/0FSix"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046AD1FB3;
	Thu, 20 Mar 2025 13:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742478572; cv=none; b=G2bePgTzBpfin3flQZdiAgs033kkhP6RgLTD/9jsH1BtRUTYj8BomZP18ecTUUGJ1Kw/YlZwUj5l7puwGFvJ0/N3eSm6xQNEcrbWB9Yjp4mewaxaB4e1Tn2qZcfTDhaANWaFhS2fvIK5eso/+yiK/B4iagms+3oldwo/kk4bV2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742478572; c=relaxed/simple;
	bh=fUJsvemNMmxmlPWa2lU5cEsAXinJz4KFQPtMblNhcPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q57ILqfZR2eOpJ6N1+jd4W+MaCaob1wrbxCJi4y5Uh1MFULJIXtJ0TMvh83/0Ozouh/gZnvCYK93G0ZQ2LXo37/+78igCveGcQ7I0V34eSHEdIcAJ/SlBGeHKUKessgcr7n+nfk7+O8ve35fXGEmy1+UBIlhrT9p9duWSeU/LG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5/0FSix; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96152C4CEDD;
	Thu, 20 Mar 2025 13:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742478571;
	bh=fUJsvemNMmxmlPWa2lU5cEsAXinJz4KFQPtMblNhcPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C5/0FSixWDMAhLhN+yx5eIyN9Buz9038d41mMKvfQuF1OkT0QepzvX0DUYBT0IHCT
	 IthbSFKfpYfeZcDlUz10UigVq7+/lTKjk0KBywGexirwoSgooNhZtXYX55hjw7fZKZ
	 wSI3dB2Ekh/6g2z276toytDntCnZke+5bqo/VQtecjpfdnQjOXRDqBOt680VuE0Z2j
	 AP/ResHWwdX5l+RFtOoCX46j6XvLsVi5ek4Zsq4jNyKYM6Y5hUw1OmeWdS26nETmyp
	 V/jtK2AMftNpvCvWKbN98bpgi3eXBNJ7WiA3/pKo0qiLT+qXBVyMT2lWIYod3WVZp5
	 XHylUOutFRegA==
Date: Thu, 20 Mar 2025 13:49:27 +0000
From: Simon Horman <horms@kernel.org>
To: Qasim Ijaz <qasdev00@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] net: ch9200: add error handling in ch9200_bind()
Message-ID: <20250320134927.GV280585@kernel.org>
References: <20250319112156.48312-1-qasdev00@gmail.com>
 <20250319112156.48312-5-qasdev00@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319112156.48312-5-qasdev00@gmail.com>

On Wed, Mar 19, 2025 at 11:21:56AM +0000, Qasim Ijaz wrote:
> The ch9200_bind() function has no error handling for any
> control_write() calls.
> 
> Fix this by checking if any control_write() call fails and 
> propagate the error to the caller.
> 
> Fixes: 4a476bd6d1d9 ("usbnet: New driver for QinHeng CH9200 devices")
> Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


