Return-Path: <netdev+bounces-157611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42088A0AFE8
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 08:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 252B818820E4
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 07:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631A3188721;
	Mon, 13 Jan 2025 07:17:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E65166F0C
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 07:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736752637; cv=none; b=mg7RIyfsFBLSwESXIig2AzGXr3YWrxwlggzkP44bxgyB34zKKtiF9W7H3XGGuyNLW94xJ2RsP6zfZobjlNucg84kOAqxx8qM2WN/YfRMCtL+wCYe13qdq6nbyLPKF/o4z7qZ/X7LNCsBrLZ7KRxMkEadT2B34xwPhigbR/3v8QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736752637; c=relaxed/simple;
	bh=TTJRMV3QkPJCJz4bQSuLp7XeszZyWtVlm7PMRYjlFAw=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=uOpagKAN1FfSwDRZld89lZAoTJ3oTkBAr55Pzg+cDC/a9hrMSYBQHC8DdMRfxay28JWQUK2Ttc25jnTPT47GgTXNQwW4wetd0Azhdp+5IbysdN2yKBZ8x2xMESRj/t3DMHKMVJ+VmZrCy88GEOdBqLJa0kGGRNSUOKYHnzAtJpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas1t1736752613t189t65490
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [36.20.58.48])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 11983999118323814274
To: "'Vadim Fedorenko'" <vadim.fedorenko@linux.dev>,
	<andrew+netdev@lunn.ch>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<richardcochran@gmail.com>,
	<linux@armlinux.org.uk>,
	<horms@kernel.org>,
	<jacob.e.keller@intel.com>,
	<netdev@vger.kernel.org>
Cc: <mengyuanlou@net-swift.com>
References: <20250110031716.2120642-1-jiawenwu@trustnetic.com> <20250110031716.2120642-2-jiawenwu@trustnetic.com> <c0228210-4991-48ad-8e2d-69b176c1d79d@linux.dev>
In-Reply-To: <c0228210-4991-48ad-8e2d-69b176c1d79d@linux.dev>
Subject: RE: [PATCH net-next v3 1/4] net: wangxun: Add support for PTP clock
Date: Mon, 13 Jan 2025 15:16:51 +0800
Message-ID: <057c01db658b$1e6f45f0$5b4dd1d0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQIn7G+o1Szt10K74NpdpmE6uZiDNwKM2ZV6AjC9LdSyVQn7IA==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NvGGTAUhB2iWaJRRr46fkvqoXSC5u3G8Oigqe/0/gIhM5Vcdo24MGV/L
	y4cVVKTzhINYdI2sh6lv2KbVoJv5/qA049GS3iLy/RXiMjPZfsmPW459SucvmwoXl/uwMN7
	Xses66fVV8uG1YOlrGdCc0jqMABAafvC8ZBVA3HfWeeKiIo8EbIhLMTskjacFc3mNyBg4+s
	U+euDj5dS1qHONdawUWGjnl8rFPNlLBmK1Wh8GAdIANap6c4VA3M825DB1H+xXl350iK4Zo
	EiDy62uClaKPD4wvmpuFd9zUii06kxJB/n0bLV8v3DNmo1AB0mu79OD06i5XgnFZSiyM+Y0
	nsH/M2/aSfwUmreW8TItlSYYKegvHYcof5cv6/90Do/YpGity7uV1EC6mE6sB61qBEJah20
	qCgvtrGgvA+zk4nwOk6K/KK4nFQVvbchh9/dT2pRwxo76B5kTJdCbDUx2DnqaWOdjGtZbx1
	heR//3/hNJHCsCnv0hRtvykhXWpSMT2mipAb79mpD/Yv1PWeixY8busbfTCarZOuckmuyzn
	/1KOVbI4SxqW16LajfaF8vcMDBiXXYAFUPmI1r45xNyhjmVXQ5V+pXJO6je+0Bte63e3DbJ
	b+eMnFKzRlE+6uLedjd5QwullTa+t+4lmuCUUNR8DXBhzBXDgGVrZQvEW74tNqSDC9MMV9z
	ZlZa/5slkCCyoGsheRC1oYKRtCOggh9xKggBVfEY37WCsRHXzTrmzW8ryI/aEx5+kG7BeiV
	U5rtuIyInQYYuceexvrTP5yQTIaWXIOvg/twkrgnu460GDByWRMG2pEwdi93Gl6P9Stb640
	Zz7toPOiUI8SRG420JmXRE3salKLl2voDh8K0klHReds6J3S+B2l5AodrkTto1bVVz1HfVo
	UEo55xLKcFd/3iszwoj8M+qbWjboNeSjI6fCUx/JGjmiE9nbVRSnNxL3QuHeObfwoXA2Pvw
	ZmUlTl/5pLngv2dO9cBmqvgssHH2pm0kLqj1rWD/eNHko+4ON1OdKzPqt
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

> > @@ -1501,12 +1535,19 @@ static netdev_tx_t wx_xmit_frame_ring(struct sk_buff *skb,
> >   	if (test_bit(WX_FLAG_FDIR_CAPABLE, wx->flags) && tx_ring->atr_sample_rate)
> >   		wx->atr(tx_ring, first, ptype);
> >
> > -	wx_tx_map(tx_ring, first, hdr_len);
> > +	if (wx_tx_map(tx_ring, first, hdr_len))
> > +		goto cleanup_tx_tstamp;
> >
> >   	return NETDEV_TX_OK;
> >   out_drop:
> >   	dev_kfree_skb_any(first->skb);
> >   	first->skb = NULL;
> > +cleanup_tx_tstamp:
> > +	if (unlikely(tx_flags & WX_TX_FLAGS_TSTAMP)) {
> > +		dev_kfree_skb_any(wx->ptp_tx_skb);
> > +		wx->ptp_tx_skb = NULL;
> > +		clear_bit_unlock(WX_STATE_PTP_TX_IN_PROGRESS, wx->state);
> > +	}
> 
> This is error path of dma mapping, means TX timestamp will be missing
> because the packet was not sent. But the error/missing counter is not
> bumped. I think it needs to be indicated.

I'll count it as 'err' in ethtool_ts_stats.

> > +static int wx_ptp_set_timestamp_mode(struct wx *wx,
> > +				     struct kernel_hwtstamp_config *config)
> > +{
> > +	u32 tsync_tx_ctl = WX_TSC_1588_CTL_ENABLED;
> > +	u32 tsync_rx_ctl = WX_PSR_1588_CTL_ENABLED;
> > +	DECLARE_BITMAP(flags, WX_PF_FLAGS_NBITS);
> > +	u32 tsync_rx_mtrl = PTP_EV_PORT << 16;
> > +	bool is_l2 = false;
> > +	u32 regval;
> > +
> > +	memcpy(flags, wx->flags, sizeof(wx->flags));
> > +
> > +	switch (config->tx_type) {
> > +	case HWTSTAMP_TX_OFF:
> > +		tsync_tx_ctl = 0;
> > +		break;
> > +	case HWTSTAMP_TX_ON:
> > +		break;
> > +	default:
> > +		return -ERANGE;
> > +	}
> > +
> > +	switch (config->rx_filter) {
> > +	case HWTSTAMP_FILTER_NONE:
> > +		tsync_rx_ctl = 0;
> > +		tsync_rx_mtrl = 0;
> > +		clear_bit(WX_FLAG_RX_HWTSTAMP_ENABLED, flags);
> > +		clear_bit(WX_FLAG_RX_HWTSTAMP_IN_REGISTER, flags);
> > +		break;
> > +	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
> > +		tsync_rx_ctl |= WX_PSR_1588_CTL_TYPE_L4_V1;
> > +		tsync_rx_mtrl |= WX_PSR_1588_MSG_V1_SYNC;
> > +		set_bit(WX_FLAG_RX_HWTSTAMP_ENABLED, flags);
> > +		set_bit(WX_FLAG_RX_HWTSTAMP_IN_REGISTER, flags);
> > +		break;
> > +	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
> > +		tsync_rx_ctl |= WX_PSR_1588_CTL_TYPE_L4_V1;
> > +		tsync_rx_mtrl |= WX_PSR_1588_MSG_V1_DELAY_REQ;
> > +		set_bit(WX_FLAG_RX_HWTSTAMP_ENABLED, flags);
> > +		set_bit(WX_FLAG_RX_HWTSTAMP_IN_REGISTER, flags);
> > +		break;
> > +	case HWTSTAMP_FILTER_PTP_V2_EVENT:
> > +	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
> > +	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
> > +	case HWTSTAMP_FILTER_PTP_V2_SYNC:
> > +	case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
> > +	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
> > +	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
> > +	case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
> > +	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
> > +		tsync_rx_ctl |= WX_PSR_1588_CTL_TYPE_EVENT_V2;
> > +		is_l2 = true;
> > +		config->rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
> > +		set_bit(WX_FLAG_RX_HWTSTAMP_ENABLED, flags);
> > +		set_bit(WX_FLAG_RX_HWTSTAMP_IN_REGISTER, flags);
> > +		break;
> > +	default:
> > +		/* register RXMTRL must be set in order to do V1 packets,
> > +		 * therefore it is not possible to time stamp both V1 Sync and
> > +		 * Delay_Req messages unless hardware supports timestamping all
> > +		 * packets => return error
> > +		 */
> > +		clear_bit(WX_FLAG_RX_HWTSTAMP_ENABLED, wx->flags);
> > +		clear_bit(WX_FLAG_RX_HWTSTAMP_IN_REGISTER, wx->flags);
> > +		config->rx_filter = HWTSTAMP_FILTER_NONE;
> > +		return -ERANGE;
> 
> looks like this code is a bit tricky and leads to out-of-sync
> configuration. Imagine the situation when HWTSTAMP_FILTER_PTP_V2_EVENT
> was configured first, the hardware was properly set up and timestamps
> are coming. wx->flags will have bits WX_FLAG_RX_HWTSTAMP_ENABLED and
> WX_FLAG_RX_HWTSTAMP_IN_REGISTER set. Then the user asks to enable
> HWTSTAMP_FILTER_ALL, which is not supported. wx->flags will have bits
> mentioned above cleared, but the hardware will still continue to
> timestamp some packets.

You are right. I'll remove the bit clears in the default case.

> > +void wx_ptp_reset(struct wx *wx)
> > +{
> > +	unsigned long flags;
> > +
> > +	/* reset the hardware timestamping mode */
> > +	wx_ptp_set_timestamp_mode(wx, &wx->tstamp_config);
> > +	wx_ptp_reset_cyclecounter(wx);
> > +
> > +	wr32ptp(wx, WX_TSC_1588_SYSTIML, 0);
> > +	wr32ptp(wx, WX_TSC_1588_SYSTIMH, 0);
> > +	WX_WRITE_FLUSH(wx);
> 
> writes to WX_TSC_1588_SYSTIML/WX_TSC_1588_SYSTIMH are not protected by
> tmreg_lock, while reads are protected in wx_ptp_read() and in
> wx_ptp_gettimex64()

No need to protect it. See below.

> > @@ -1133,6 +1168,21 @@ struct wx {
> >   	void (*atr)(struct wx_ring *ring, struct wx_tx_buffer *first, u8 ptype);
> >   	void (*configure_fdir)(struct wx *wx);
> >   	void (*do_reset)(struct net_device *netdev);
> > +
> > +	u32 base_incval;
> > +	u32 tx_hwtstamp_pkts;
> > +	u32 tx_hwtstamp_timeouts;
> > +	u32 tx_hwtstamp_skipped;
> > +	u32 rx_hwtstamp_cleared;
> > +	unsigned long ptp_tx_start;
> > +	spinlock_t tmreg_lock; /* spinlock for ptp */
> 
> Could you please explain what this lock protects exactly? According to
> the name, it should serialize access to tm(?) registers, but there is
> a mix of locked and unlocked accesses in the code ...
> If this lock protects cyclecounter/timecounter then it might be better
> to use another name, like hw_cc_lock. And in this case it's even better
> to use seqlock_t with reader/writer accessors according to the code path.

It is for struct timecounter. The registers are read only to update the cycle
counter. I think  it's better to  name it hw_tc_lock.
 


