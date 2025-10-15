Return-Path: <netdev+bounces-229685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 289ECBDFBD3
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 18:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE563507616
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 16:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489B1324B1D;
	Wed, 15 Oct 2025 16:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OfXji97u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1261C189B84;
	Wed, 15 Oct 2025 16:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760546809; cv=none; b=UkRUStio8P1Bp5LHRCUcIfWBDodm96tNw8I7ZyzPz//3Lr7huMNsjwEj5sAPdjmQup8UGqrqWIU75oDLTAMmFAzwHBCAUQnm497VCxmtMEsVwjmRQXtlfO8a+Jb5EoDP+Zd46RYh57eRmhGjM2BOPB3JbbcfGZQATczWszUz9JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760546809; c=relaxed/simple;
	bh=0FFNgUviHoyceqwAxmTDFq28OH826jRwx6eKiDBtnic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADzeWmN1MfHoRm0nyJ/ALTrSR7cUUt486qpjwk++4ngICm/8olPkULag3Tu+rj0nAhMleYpvsbwgDvJbKhZ+WxEebmPdrWn5DqYh6tYDVlfbnWZvqLhxVC23XexAzxwYvojaSZ9aE0Apudxm9tZB4VS0NV3wPtGyZVOoRJAqRAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OfXji97u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7179AC4CEF8;
	Wed, 15 Oct 2025 16:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760546807;
	bh=0FFNgUviHoyceqwAxmTDFq28OH826jRwx6eKiDBtnic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OfXji97uoG3XgHw5juL0tZXh1xnYncQ0aojjso9wV/kpxikKg37uBjRkYxztPwIvG
	 w6CBKKmWmoLzPAFdSqUHwKfZMZ23NaZkkisyHySya5v0041rkqYsS+PUKO72BZjHx+
	 ytagA9wccAVraEB7lA4/ING+gj3PiUFQ2ubnl7QR64JVYBhYOXZ6ljQDgcxcBS+Gme
	 l4twauTa+1rsib58oWR8BY7tSGY9eQkfNKo7U7jQpYg9SRgvNNs9KcFf/A9Q5KgpSN
	 gMPmr11o19K4023AuZ1vcNtZ+BImSAmvzpvW+w54erBx4/HjjZT54jmFqY1eqJHB/T
	 bk3s91j+CVhvQ==
Date: Wed, 15 Oct 2025 17:46:40 +0100
From: Simon Horman <horms@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
	Jonathan Corbet <corbet@lwn.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Gur Stavi <gur.stavi@huawei.com>, Jakub Kicinski <kuba@kernel.org>,
	Joe Damato <jdamato@fastly.com>, Lee Trager <lee@trager.us>,
	luosifu@huawei.com, luoyang82@h-partners.com,
	Meny Yossefi <meny.yossefi@huawei.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Shen Chenyang <shenchenyang1@hisilicon.com>,
	Shi Jing <shijing34@huawei.com>, Suman Ghosh <sumang@marvell.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Wu Like <wulike1@huawei.com>, Xin Guo <guoxin09@huawei.com>,
	Zhou Shuai <zhoushuai28@huawei.com>
Subject: Re: [PATCH net-next 2/9] hinic3: Add PF management interfaces
Message-ID: <aO_P8F3CuY4ZvmiY@horms.kernel.org>
References: <68ddc5e9191fcb12d1adb666a3e451af6404ec76.1760502478.git.zhuyikai1@h-partners.com>
 <b59d625d-18c8-49c9-9e96-bb4e2f509cd7@web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b59d625d-18c8-49c9-9e96-bb4e2f509cd7@web.de>

On Wed, Oct 15, 2025 at 12:00:33PM +0200, Markus Elfring wrote:
> > To: Fan Gong …
> 
> Please reconsider the distribution of recipient information between message fields
> once more.
> 
> 
> …
> > +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt.c
> > @@ -3,19 +3,325 @@
> …
> > +static void mgmt_resp_msg_handler(struct hinic3_msg_pf_to_mgmt *pf_to_mgmt,
> > +				  struct hinic3_recv_msg *recv_msg)
> > +{
> …
> > +	spin_lock(&pf_to_mgmt->sync_event_lock);
> > +	if (recv_msg->msg_id != pf_to_mgmt->sync_msg_id) {
> …
> > +	}
> > +	spin_unlock(&pf_to_mgmt->sync_event_lock);
> > +}
> …
> 
> Will development interests grow to apply a call like “scoped_guard(spinlock, &pf_to_mgmt->sync_event_lock)”?
> https://elixir.bootlin.com/linux/v6.17.1/source/include/linux/spinlock.h#L565-L567

Hi Markus, all.

It's up to the developer. But there is a still a weak preference
for open-coding, as is done above, in Networking code. So in the
absence of some other motivation (I have not reviewed this code)
I would suggest leaving this as-is.

https://docs.kernel.org/process/maintainer-netdev.html#using-device-managed-and-cleanup-h-constructs

