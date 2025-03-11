Return-Path: <netdev+bounces-173885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FC9A5C1A7
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 13:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E65E3A9988
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 12:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E856250C11;
	Tue, 11 Mar 2025 12:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MFNKq0Db"
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2201EA7FD
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 12:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741697495; cv=none; b=mDFvPW9clD03GK/r+0+krsYx2RKej5o+B9ubOK3OAF2auYgWJmaCtPGZdrQVvhIjuKXuZKexNDlTcBFd0a0/MiBwcbBnp9PsoXR1h2npOpGRFEXiho9LPgluBQSGiiJLwpUrdKLs2gCR6+k6YJVjYknuhDEQXwuub5nsAtPOA3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741697495; c=relaxed/simple;
	bh=KmF+4zJ8JclvHmT5HnU2BmRfsjBMEGKl3Que0NW7Qrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=DCrnA7ub/6DpJ1rys//SbebiekQEKWLXjwBWYFpaX+UxJ4CTLqMGz+S0exF4TXoJEPmTrdRrwGgUMdZx0AtMOyA3e6/MEcgJkiPT5CPuBw/S02Rn1bJubchC7J3hbn2rhOErD69Hu00Jws/ZuHdHXbGbTOLlGUTCJAtSgVe4aKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=MFNKq0Db; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250311125125euoutp01d99548def382cc60fbc512a729e7f9b4~rwKJ9vTY70779207792euoutp01J
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 12:51:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250311125125euoutp01d99548def382cc60fbc512a729e7f9b4~rwKJ9vTY70779207792euoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741697485;
	bh=dnf/ASi3GnbN2CMqDrsLAENksVAqTq9VEfIXEJdF0qQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=MFNKq0DbDnJpaAeGY534MN/NLlkvjA4WIZdsVd+Ws17qKfuDSeJAP+xSvNAr/GfVC
	 4IZXDf7LxA2gBJ2JR5XSI7tGp7WH1pqlOCmVM69as0sVJrh6KCUFxB6o7+lajHIUAS
	 XLrMKjV2FuYlJYDJKljnRPC3hMd7Wkwtt6QoloXY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250311125124eucas1p1eb4b347dc2332b59b0675e5afc66b936~rwKJihjGb0432104321eucas1p1w;
	Tue, 11 Mar 2025 12:51:24 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 4E.D2.20397.CC130D76; Tue, 11
	Mar 2025 12:51:24 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250311125124eucas1p136fb8eb9d2cd360bd33093f45f2748f4~rwKJJjwmz0432304323eucas1p14;
	Tue, 11 Mar 2025 12:51:24 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250311125124eusmtrp143ce184b585b792697612be27e56e84a~rwKJGHPZW0602406024eusmtrp1g;
	Tue, 11 Mar 2025 12:51:24 +0000 (GMT)
X-AuditID: cbfec7f5-e59c770000004fad-a6-67d031cc148c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 17.9A.19920.BC130D76; Tue, 11
	Mar 2025 12:51:24 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250311125122eusmtip2c4b2477809b08d989e40fa2aa9e27e25~rwKIA7LnQ2117321173eusmtip2M;
	Tue, 11 Mar 2025 12:51:22 +0000 (GMT)
Message-ID: <067bd072-eb3f-451a-b1c4-59eae777cf00@samsung.com>
Date: Tue, 11 Mar 2025 13:51:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1 1/1] bnx2: Fix unused data compilation warning
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jakub Kicinski
	<kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Christoph Hellwig <hch@lst.de>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Rasesh Mody
	<rmody@marvell.com>, GR-Linux-NIC-Dev@marvell.com, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
	Dumazet <edumazet@google.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <Z8ggoUoKpSPPcs5S@smile.fi.intel.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAKsWRmVeSWpSXmKPExsWy7djPc7pnDC+kGxzZIm+x/MEOVovepulM
	FnPOt7BYPD32iN3iwSJGi5WrjzJZXNjWx2pxedccNotjC8Qsvp1+w2jxZtsiZgdujy0rbzJ5
	LNhU6rFpVSebx7yTgR67bzaweezc8ZnJY/LCi8we7/ddZfP4vEkugDOKyyYlNSezLLVI3y6B
	K+PW/vlMBQc1Kub8XczcwDhPuYuRg0NCwERi7cSMLkYuDiGBFYwSu1/uZIVwvjBKPL3ZwwTh
	fGaU+L6kC8jhBOs4t/kPG4gtJLCcUWL7ymiIoo+MEn+WbQZL8ArYSexo2cAIYrMIqEq8ObOH
	HSIuKHFy5hMWEFtUQF7i/q0Z7CBnCAt4SnzaXAkSFhGIlri0fz4zyExmgU1MEpsebwfrZRYQ
	l7j1ZD7YEWwChhJdb7vAdnEKGEk8/naHGaJGXmL72znMEIdO5pRYcTkPwnaRuPhrKiOELSzx
	6vgWdghbRuL05B4WkGUSAu2MEgt+32eCcCYwSjQ8vwXVYS1x59wvNpBLmQU0Jdbv0ocIO0qs
	vvSLHRKOfBI33gpC3MAnMWnbdGaIMK9ER5sQRLWaxKzj6+DWHrxwiXkCo9IspFCZheTLWUi+
	mYWwdwEjyypG8dTS4tz01GLjvNRyveLE3OLSvHS95PzcTYzARHb63/GvOxhXvPqod4iRiYPx
	EKMEB7OSCO/BK+fShXhTEiurUovy44tKc1KLDzFKc7AoifMu2t+aLiSQnliSmp2aWpBaBJNl
	4uCUamBK6RLYudsyQM/j7Ipf30QVd5/49dlnYpnHuiP7rabf271jcpehduyb4PrJcp/Wfl/+
	4MIsTmvDo58Zb3Xlm3ge7TD4++vOj+gL/2pfObySid6vvVpxZUedhe4Xnc0tb7adTCph2/On
	7pRsYZG70+I/jWabn2Yc1xFgyk14tsJ3vVk6y7Xb2xKkFlxI0j0dLmsu5rjs5X2WCZKS905Z
	X7Bfx1D7d2nermP7Iv9eWvy1bVOQxmz7O6FiJf8OuV86sH/Ww2XnZG6zXO1+kTKZ5cdPNsEi
	sZRFPPqs8wo0LrGfnXdSxfV67PaQz272HTtubv0T/O0k+2uW7RGy9udeWXfKxV9q41ghclvs
	W3736Ytmu5RYijMSDbWYi4oTAXxWW+TTAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsVy+t/xe7pnDC+kG9x9yWix/MEOVovepulM
	FnPOt7BYPD32iN3iwSJGi5WrjzJZXNjWx2pxedccNotjC8Qsvp1+w2jxZtsiZgdujy0rbzJ5
	LNhU6rFpVSebx7yTgR67bzaweezc8ZnJY/LCi8we7/ddZfP4vEkugDNKz6Yov7QkVSEjv7jE
	Vina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL+PW/vlMBQc1Kub8XczcwDhP
	uYuRk0NCwETi3OY/bF2MXBxCAksZJZ7du8wKkZCRODmtAcoWlvhzrQuq6D2jxNvTE9lBErwC
	dhI7WjYwgtgsAqoSb87sgYoLSpyc+YQFxBYVkJe4f2sGUJyDQ1jAU+LT5koQU0QgWuJndx5I
	BbPAJiaJhVNLQWwhgR3MEl8nlkLExSVuPZnPBGKzCRhKdL0FOYGTg1PASOLxtzvMEDVmEl1b
	uxghbHmJ7W/nME9gFJqF5IhZSEbNQtIyC0nLAkaWVYwiqaXFuem5xYZ6xYm5xaV56XrJ+bmb
	GIGRu+3Yz807GOe9+qh3iJGJg/EQowQHs5II78Er59KFeFMSK6tSi/Lji0pzUosPMZoCQ2Ii
	s5Rocj4wdeSVxBuaGZgamphZGphamhkrifO6XT6fJiSQnliSmp2aWpBaBNPHxMEp1cDkKPJ2
	6gSZrFXVfDNehF28sXzmh8LD4qWVat/txFa9n2r6U32rruRUy38796Te0l9Zu+HYpisfbd/t
	Snp04U02/1HLfY62a21+zdqiasKr8t7m+7uceSH7vH/96I5odOLtkrzomnowjHNrTa6Nt0fZ
	Wy71rQtdrim0Zdyykjh2XXLGp3sfkzqf2K7fy7th8osvc9Tcl6kqPH4x2eTs1rcLAxZMOWbI
	cbz81gyGzU4VhTc25E3/d/S+ic2/FYmXDESqYyvL3rRlezwV9Sw4EJerJ+m08riYssjk0Ftm
	VZPEOtt/tl0pW3zw3/NdtTPvlFz7uogjxK7s//0eEelHql265zu3/pJn91bcmLGlM8d4mRJL
	cUaioRZzUXEiAN8HK4llAwAA
X-CMS-MailID: 20250311125124eucas1p136fb8eb9d2cd360bd33093f45f2748f4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250305100010eucas1p1986206542bc353300aee7ac8d421807f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250305100010eucas1p1986206542bc353300aee7ac8d421807f
References: <20250228100538.32029-1-andriy.shevchenko@linux.intel.com>
	<20250303172114.6004ef32@kernel.org> <Z8bcaR9MS7dk8Q0p@smile.fi.intel.com>
	<5ec0a2cc-e5f6-42dd-992c-79b1a0c1b9f5@redhat.com>
	<Z8bq6XJGJNbycmJ9@smile.fi.intel.com> <Z8cC_xMScZ9rq47q@smile.fi.intel.com>
	<20250304083524.3fe2ced4@kernel.org>
	<CGME20250305100010eucas1p1986206542bc353300aee7ac8d421807f@eucas1p1.samsung.com>
	<Z8ggoUoKpSPPcs5S@smile.fi.intel.com>

Hi Andy,

On 05.03.2025 11:00, Andy Shevchenko wrote:
> On Tue, Mar 04, 2025 at 08:35:24AM -0800, Jakub Kicinski wrote:
>> On Tue, 4 Mar 2025 15:41:19 +0200 Andy Shevchenko wrote:
> ...
>
>>>>> Would that work?
>>> Actually it won't work because the variable is under the same ifdeffery.
>>> What will work is to spreading the ifdeffery to the users, but it doesn't any
>>> better than __maybe_unsused, which is compact hack (yes, I admit that it is not
>>> the nicest solution, but it's spread enough in the kernel).
>> I meant something more like (untested):
> We are starving for the comment from the DMA mapping people.

I'm really sorry for this delay. Just got back to the everyday stuff 
after spending a week in bed recovering from flu...

>> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
>> index b79925b1c433..a7ebcede43f6 100644
>> --- a/include/linux/dma-mapping.h
>> +++ b/include/linux/dma-mapping.h
>> @@ -629,10 +629,10 @@ static inline int dma_mmap_wc(struct device *dev,
>>   #else
>>   #define DEFINE_DMA_UNMAP_ADDR(ADDR_NAME)
>>   #define DEFINE_DMA_UNMAP_LEN(LEN_NAME)
>> -#define dma_unmap_addr(PTR, ADDR_NAME)           (0)
>> -#define dma_unmap_addr_set(PTR, ADDR_NAME, VAL)  do { } while (0)
>> -#define dma_unmap_len(PTR, LEN_NAME)             (0)
>> -#define dma_unmap_len_set(PTR, LEN_NAME, VAL)    do { } while (0)
>> +#define dma_unmap_addr(PTR, ADDR_NAME)           ({ typeof(PTR) __p __maybe_unused = PTR; 0; )}
>> +#define dma_unmap_addr_set(PTR, ADDR_NAME, VAL)  do { typeof(PTR) __p __maybe_unused = PTR; } while (0)
>> +#define dma_unmap_len(PTR, LEN_NAME)             ({ typeof(PTR) __p __maybe_unused = PTR; 0; )}
>> +#define dma_unmap_len_set(PTR, LEN_NAME, VAL)    do { typeof(PTR) __p __maybe_unused = PTR; } while (0)
>>   #endif
>>   
>>   #endif /* _LINUX_DMA_MAPPING_H */
>>
>> I just don't know how much code out there depends on PTR not
>> existing if !CONFIG_NEED_DMA_MAP_STATE
> Brief checking shows that only drivers/net/ethernet/chelsio/* comes
> with ifdeffery, the rest most likely will fail in the same way
> (note, overwhelming majority of the users is under the network realm):

Frankly speaking I wasn't aware of this API till now.

If got it right the above proposal should work fine. The addr/len names 
can be optimized out, but the pointer to the container should exist.


> $ git grep -lw dma_unmap_[al][de].*
>
> drivers/infiniband/hw/cxgb4/cq.c
> drivers/infiniband/hw/cxgb4/qp.c
> drivers/infiniband/hw/mthca/mthca_allocator.c
> drivers/infiniband/hw/mthca/mthca_eq.c
> drivers/net/ethernet/alacritech/slicoss.c
> drivers/net/ethernet/alteon/acenic.c
> drivers/net/ethernet/amazon/ena/ena_netdev.c
> drivers/net/ethernet/arc/emac_main.c
> drivers/net/ethernet/atheros/alx/main.c
> drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
> drivers/net/ethernet/broadcom/bcmsysport.c
> drivers/net/ethernet/broadcom/bnx2.c
> drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
> drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
> drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
> drivers/net/ethernet/broadcom/bnxt/bnxt.c
> drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> drivers/net/ethernet/broadcom/genet/bcmgenet.c
> drivers/net/ethernet/broadcom/tg3.c
> drivers/net/ethernet/brocade/bna/bnad.c
> drivers/net/ethernet/chelsio/cxgb/sge.c
> drivers/net/ethernet/chelsio/cxgb3/sge.c
> drivers/net/ethernet/emulex/benet/be_main.c
> drivers/net/ethernet/engleder/tsnep_main.c
> drivers/net/ethernet/google/gve/gve_tx.c
> drivers/net/ethernet/google/gve/gve_tx_dqo.c
> drivers/net/ethernet/intel/fm10k/fm10k_main.c
> drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
> drivers/net/ethernet/intel/i40e/i40e_main.c
> drivers/net/ethernet/intel/i40e/i40e_txrx.c
> drivers/net/ethernet/intel/i40e/i40e_xsk.c
> drivers/net/ethernet/intel/iavf/iavf_txrx.c
> drivers/net/ethernet/intel/ice/ice_txrx.c
> drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
> drivers/net/ethernet/intel/idpf/idpf_txrx.c
> drivers/net/ethernet/intel/igb/igb_ethtool.c
> drivers/net/ethernet/intel/igb/igb_main.c
> drivers/net/ethernet/intel/igc/igc_dump.c
> drivers/net/ethernet/intel/igc/igc_main.c
> drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> drivers/net/ethernet/marvell/skge.c
> drivers/net/ethernet/marvell/sky2.c
> drivers/net/ethernet/mediatek/mtk_eth_soc.c
> drivers/net/ethernet/mscc/ocelot_fdma.c
> drivers/net/ethernet/myricom/myri10ge/myri10ge.c
> drivers/net/ethernet/qlogic/qla3xxx.c
> drivers/net/ethernet/rocker/rocker_main.c
> drivers/net/ethernet/wangxun/libwx/wx_lib.c
> drivers/net/wireless/intel/iwlegacy/3945-mac.c
> drivers/net/wireless/intel/iwlegacy/3945.c
> drivers/net/wireless/intel/iwlegacy/4965-mac.c
> drivers/net/wireless/intel/iwlegacy/common.c
> drivers/net/wireless/marvell/mwl8k.c
>
> include/net/libeth/tx.h
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


