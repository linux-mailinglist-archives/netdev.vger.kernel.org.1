Return-Path: <netdev+bounces-261110-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEcGHg6dn2mucwQAu9opvQ
	(envelope-from <netdev+bounces-261110-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 02:08:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA28119FBA7
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 02:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5AE503033E53
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 01:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9157C2C15A0;
	Thu, 26 Feb 2026 01:08:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2463A1A08AF;
	Thu, 26 Feb 2026 01:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772068105; cv=none; b=lsufoCwEYH5iJ45PZjxSGLOx5BPmn/ujsGCyca68CtqQzBApRSw42Y86n33QcxfF2Cs/5MroIJKMrAjE74Wj/72kQry+TgFFOZD38dk4efieosc8VJB3/ZP+UEOxPcx9ng9l/iG8AewlqvlzrOvM3hcRLyKI0CVqPgIuQ/5zqHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772068105; c=relaxed/simple;
	bh=oQKZOa6pyE8exsu7Kw5gUCx2X2Y+51MwP15z1ZHcNzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gfZPfYmVqiD753ogRWodtgmtfTXsaaDIyzngpiJH4CArqHDKzWxM+ovopDt1j3z7OP9+RAe1DEk7Zhg3aPyYune1SYxab+NhI9iDP7paD0SiPpvE8etOkhg3u+wSLzrYFNblJ4oVtxsSp0DKTOGjQaKFcepaEqTtzPoyqdFVVLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-e5-699f9d01b8b5
Date: Thu, 26 Feb 2026 10:08:11 +0900
From: Byungchul Park <byungchul@sk.com>
To: netdev@vger.kernel.org, kuba@kernel.org
Cc: linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
	harry.yoo@oracle.com, david@redhat.com, willy@infradead.org,
	toke@redhat.com, asml.silence@gmail.com, almasrymina@google.com,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, intel-wired-lan@lists.osuosl.org
Subject: Re: [RESEND PATCH] ice: access @pp through netmem_desc instead of
 page
Message-ID: <20260226010811.GA16777@system.software.com>
References: <20260224053546.62757-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224053546.62757-1-byungchul@sk.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsXC9ZZnoS7j3PmZBk8/cFis/lFhsfzBDlaL
	3Rd+MFnMWbWN0WLO+RYWi6/rfzFbPD32iN3i/rJnLBb/b/1mtbiwrY/V4vKuOWwWxxaIWXw7
	/YbR4vbSq0wWlw4/YrH4/WMOm4OAx5aVN5k8ds66y+6xYFOpx+YVWh6L97xk8ti0qpPN42Rz
	qcfOHZ+ZPD4+vcXi8X7fVTaPz5vkArijuGxSUnMyy1KL9O0SuDIunFrHXvCSs2L51k9MDYzt
	HF2MnBwSAiYSVy6+Z4Ox5x85ywRiswioSty4f5URxGYTUJe4ceMnM4gtIqAtsfJ8BwuIzSzw
	kUlixg0uEFtYIFDi3IUjYHN4BSwkem98BasREjCV+HF5PSNEXFDi5MwnUL1aEjf+vQTaxQFk
	S0ss/wd2DqeAmcTen5PASkQFlCUObDvOBHFaN7vE6nuaELakxMEVN1gmMArMQjJ1FpKpsxCm
	LmBkXsUolJlXlpuYmWOil1GZl1mhl5yfu4kRGGXLav9E72D8dCH4EKMAB6MSD2/Ez3mZQqyJ
	ZcWVuYcYJTiYlUR473wACvGmJFZWpRblxxeV5qQWH2KU5mBREuc1+laeIiSQnliSmp2aWpBa
	BJNl4uCUamDUvHfn3fll2vsbVj+rvqTcNvul0/TbnybVaW3/+CPnlLqZ4YPNnPt94y1u2Xgc
	z5v/7t+qwLZLDaXqiY+PKqWVTz9rluL/MWWh2+EZVlfahI2sLVMM323Inrl26eRTSe766j8M
	zpeL/RNXLs22Tc+2fvRYo7Zy7+ZE1jM3L6ZnLdidOqvmtJiKEktxRqKhFnNRcSIAruq4f64C
	AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmkeLIzCtJLcpLzFFi42Lh8rNu1mWYOz/T4NhOG4vVPyoslj/YwWqx
	+8IPJos5q7YxWsw538Ji8XX9L2aLp8cesVvcX/aMxeL/rd+sFofnnmS1uLCtj9Xi8q45bBbH
	FohZfDv9htHi9tKrTBaXDj9isfj9Yw6bg6DHlpU3mTx2zrrL7rFgU6nH5hVaHov3vGTy2LSq
	k83jZHOpx84dn5k8Pj69xeLxft9VNo/FLz4weXzeJBfAE8Vlk5Kak1mWWqRvl8CVceHUOvaC
	l5wVy7d+YmpgbOfoYuTkkBAwkZh/5CwTiM0ioCpx4/5VRhCbTUBd4saNn8wgtoiAtsTK8x0s
	IDazwEcmiRk3uEBsYYFAiXMXjrCB2LwCFhK9N76C1QgJmEr8uLyeESIuKHFy5hOoXi2JG/9e
	Au3iALKlJZb/AzuBU8BMYu/PSWAlogLKEge2HWeawMg7C0n3LCTdsxC6FzAyr2IUycwry03M
	zDHVK87OqMzLrNBLzs/dxAiMmmW1fybuYPxy2f0QowAHoxIPb8TPeZlCrIllxZW5hxglOJiV
	RHjvfAAK8aYkVlalFuXHF5XmpBYfYpTmYFES5/UKT00QEkhPLEnNTk0tSC2CyTJxcEo1MKbq
	60++8WyZpCyvx3WVogdhLNn+t2xKf/qvizC6+yKfbV5qm/+HMKMH/xxi5vxLlsu56tJ/VOuw
	s+XMqa/PPtOv2/E7nq+H45q8p7yASJrYrZicxVaGeve/ymz659tdfMnqae3lPR9iF3dvj83b
	0fDmd5bPmxCfGKM1iVuf32Sa/o3V0+jGfSWW4oxEQy3mouJEAJV/J7GWAgAA
X-CFilter-Loop: Reflected
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261110-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[sk.com];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_CC(0.00)[vger.kernel.org,skhynix.com,oracle.com,redhat.com,infradead.org,gmail.com,google.com,intel.com,lunn.ch,davemloft.net,lists.osuosl.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[byungchul@sk.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.931];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sk.com:email,system.software.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DA28119FBA7
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 02:35:46PM +0900, Byungchul Park wrote:
> To eliminate the use of struct page in page pool, the page pool users
> should use netmem descriptor and APIs instead.
> 
> Make ice driver access @pp through netmem_desc instead of page.

Hi Tony and Przemek,

Is there something that I'm missing or something wrong with this?  Your
feedback would be appreciated.  Thanks!

	Byungchul

> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> index c6bc29cfb8e6..c16e54dbe75b 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -1251,7 +1251,7 @@ static int ice_lbtest_receive_frames(struct ice_rx_ring *rx_ring)
>  		rx_buf = &rx_ring->rx_fqes[i];
>  		page = __netmem_to_page(rx_buf->netmem);
>  		received_buf = page_address(page) + rx_buf->offset +
> -			       page->pp->p.offset;
> +			       pp_page_to_nmdesc(page)->pp->p.offset;
>  
>  		if (ice_lbtest_check_frame(received_buf))
>  			valid_frames++;
> -- 
> 2.17.1

