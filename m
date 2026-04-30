Return-Path: <netdev+bounces-282708-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMRVNBgU82llxAEAu9opvQ
	(envelope-from <netdev+bounces-282708-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 10:34:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A26F49F490
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 10:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F0B23300644C
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 08:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF263FB04E;
	Thu, 30 Apr 2026 08:34:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963F33FA5E4
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 08:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777538069; cv=none; b=IMS3SJZS20zMRWs3GBCOONOzUBOJDd/yb6KhRS24WtVTrydMq+oZv5Xh+fqvyNnqYFD5Eqwae/bNKabvu9uVpVQ9WdcOJKOPiCktRO7Xj2QD+c3l6tRlvdcKApTnfYuoyDh11Xw+S8TteUPX8Z8Ba8oBBSqaFzeNu1alXV6nOi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777538069; c=relaxed/simple;
	bh=3J2BOkH8Z7CPFtuFHvGI9hQyGfSAjKTyIyU2U2jcOcA=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=c6k3uilAzzDcxyarG8pq6eqaxOnpgu5QzRivaWI+RWWl4zeVNJ9IO2IOqWTfh9ZUzDnC4wl4B45CURyYGXaMSPyyA4CXqJXFFFTTsxqaXQ7pr8UVoZMUvdMSjEi9qMgG/0v//liFMSQaHhaOwuTdV1yDdJDCN+PPpVvTpr5LVKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas5t1777538036t933t22487
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [122.235.155.141])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 2990379040600667830
To: "'Paolo Abeni'" <pabeni@redhat.com>,
	<netdev@vger.kernel.org>
Cc: "'Mengyuan Lou'" <mengyuanlou@net-swift.com>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Richard Cochran'" <richardcochran@gmail.com>,
	"'Russell King'" <linux@armlinux.org.uk>,
	"'Simon Horman'" <horms@kernel.org>,
	"'Kees Cook'" <kees@kernel.org>,
	"'Larysa Zaremba'" <larysa.zaremba@intel.com>,
	"'Breno Leitao'" <leitao@debian.org>,
	"'Joe Damato'" <joe@dama.to>,
	"'Jacob Keller'" <jacob.e.keller@intel.com>,
	"'Fabio Baltieri'" <fabio.baltieri@gmail.com>
References: <20260428021156.13564-1-jiawenwu@trustnetic.com> <20260428021156.13564-3-jiawenwu@trustnetic.com> <fb036ffe-b2da-4e9a-a3f4-0f0e467b9e25@redhat.com>
In-Reply-To: <fb036ffe-b2da-4e9a-a3f4-0f0e467b9e25@redhat.com>
Subject: RE: [PATCH net-next v1 2/5] net: wangxun: add Tx timeout process
Date: Thu, 30 Apr 2026 16:33:55 +0800
Message-ID: <040901dcd87c$155a0e40$400e2ac0$@trustnetic.com>
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
Thread-Index: AQLF62GY0jPNAUMm+EZ4bbRu+eO8jAHXKjJiAl30BQy0A3aeoA==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NVMB8zCAZkjSh/IavtM3rjWgcZK5DnqeexZAoQ1BafTkxNQ0cmH22f2P
	FdkSGzwSZ3MfPdLvWcpRI0sxxlYBytygxFnJmdht4OmPJJb7h333w1u+7l2HBHL0WsEh+1d
	53b6JCJkf2ogqbQrCKr+9Dl8tx0USWQu3ACrSvPKTyv5qyqcotIfSIRt/WNmFDkl5CsvzsS
	/trbKbGVtlt3oGEQw5Tci/UjwqYJiY7BozJdd0JSfJzjoD6bA22eoD+fkBCeT6IO6D7CTrW
	enMI136GS52zI4m3HtFB3p+haI2Mb2BkxMsD7sDkDL5rgCYEDlwbqKO5msk4kk6DGGgmA2o
	44LlIxmoVI12nboCVzJADXj5l95Ds+r9sDQ4tp+/2ykz23aE/L0gOCTNYOIC4tsForP8+cy
	RkGVsHeYkFU7CIE8JSweGver3+/6mDpWEzLWRvRFJgBhrfRWLSH5uqNukgyA1p6XWKPhueS
	naMfyYF8qDUib64z4cq5yyu8tUawtwwjdZLF34sudfLKZY2fVN9WFMg+BeYSHfaPwf+Srj3
	dMWgSElSzM6uU/ERlH33ghYe2ZhZWL+hMAfQBiUAeFEtPi5vNALtkrGzUpm5GMWoG1CePxl
	kf1Fnr7/jewyQKTEfVXZ+yhb1J2/8V7/FuGxbha4GRmm+dckQgddJS7UeD64eBhYKenPxHC
	cIHFBhJOpLdhZqHzvkNSLTIEmPwNoSWvd9D19qeFzJnTkmThnqUFUIl89uMlZ/M7v+ihhth
	mgz/Npxd537kz9pFn53khntpdE/Ey/GknU59+kizxBj31K8eiZTweDzgmh+agcpWGoHc4bF
	0mwSxnJmE5XtjrjisIFBZQR7mIhxreRrnFxzquHAv7dAfW9r/P9VdRJeK/aAZ/bPTc2vMEe
	Alj03VnQHXUQukeL/xVggOCq0hJlm18puMEmtt6H49CcmfQR+21O8OaOaO28Lwln44vKQ4H
	d6mvI4OV8v/sSGA2o21o2wlFkct2ZHE27EkP+pPWzA76sfx61x2uCNavH1pUwgjQqbt/jMQ
	dHTQoOk0Mc0PwpWOTZV6Jjbv3/Ws4crHpEtj9bQeGNHRzz/ALaXxItv90EOQf4flRzLLzik
	pPo4E6Hr3rZnCnYFWIF+kQA5/Wc8RyP3g==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 9A26F49F490
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	FROM_EXCESS_BASE64(1.50)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282708-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,gmail.com,armlinux.org.uk,intel.com,debian.org,dama.to];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_SPAM(0.00)[0.141];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[trustnetic.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Thu, April 30, 2026 4:24 PM, Paolo Abeni wrote:
> On 4/28/26 4:11 AM, Jiawen Wu wrote:
> > +static void wx_reset_subtask(struct wx *wx)
> > +{
> > +	if (!test_bit(WX_FLAG_NEED_PF_RESET, wx->flags))
> > +		return;
> > +
> > +	rtnl_lock();
> > +
> > +	if (!netif_running(wx->netdev) ||
> > +	    test_bit(WX_STATE_RESETTING, wx->state))
> > +		return;
> 
> Sashiko says:
> 
> Does this early return path leak the rtnl_lock?
> If the interface is brought down concurrently while a reset is scheduled,
> it appears this would return without calling rtnl_unlock(). Since all
> network
> configuration operations require the RTNL lock, could this lead to a
> system-wide deadlock in the networking subsystem?

Thanks for your review.
Unfortunately, I just sent V2 patch set address on Sashiko's comments...
I'll make V3 patches according to your follow comments.

> 
> > +
> > +	wx_warn(wx, "Reset adapter.\n");
> > +
> > +	if (test_and_clear_bit(WX_FLAG_NEED_PF_RESET, wx->flags)) {
> > +		if (wx->do_reset)
> > +			wx->do_reset(wx->netdev);
> > +	}
> > +
> > +	rtnl_unlock();
> > +}
> > +
> > +/*
> > + * wx_check_tx_hang_subtask - check for hung queues and dropped interrupts
> > + * @wx - pointer to the device wx structure
> > + *
> > + * This function serves two purposes.  First it strobes the interrupt lines
> > + * in order to make certain interrupts are occurring.  Secondly it sets the
> > + * bits needed to check for TX hangs.  As a result we should immediately
> > + * determine if a hang has occurred.
> > + */
> > +static void wx_check_tx_hang_subtask(struct wx *wx)
> > +{
> > +	int i;
> > +
> > +	/* If we're down or resetting, just bail */
> > +	if (!netif_running(wx->netdev) ||
> > +	    test_bit(WX_STATE_RESETTING, wx->state))
> > +		return;
> > +
> > +	/* Force detection of hung controller */
> > +	if (netif_carrier_ok(wx->netdev)) {
> > +		for (i = 0; i < wx->num_tx_queues; i++)
> > +			set_bit(WX_TX_DETECT_HANG, wx->tx_ring[i]->state);
> > +	}
> > +}
> > +
> > +void wx_handle_errors_subtask(struct wx *wx)
> > +{
> > +	wx_reset_subtask(wx);
> > +	wx_check_tx_hang_subtask(wx);
> > +}
> > +EXPORT_SYMBOL(wx_handle_errors_subtask);
> > +
> > +static void wx_tx_timeout_reset(struct wx *wx)
> > +{
> > +	if (!netif_running(wx->netdev))
> > +		return;
> > +
> > +	set_bit(WX_FLAG_NEED_PF_RESET, wx->flags);
> > +	wx_warn(wx, "initiating reset due to tx timeout\n");
> > +	wx_service_event_schedule(wx);
> > +}
> > +
> > +void wx_tx_timeout(struct net_device *netdev, unsigned int txqueue)
> > +{
> > +	struct wx *wx = netdev_priv(netdev);
> > +	u32 head, tail;
> > +	int i;
> > +
> > +	for (i = 0; i < wx->num_tx_queues; i++) {
> > +		struct wx_ring *tx_ring = wx->tx_ring[i];
> > +
> > +		if (test_bit(WX_TX_DETECT_HANG, tx_ring->state) &&
> > +		    wx_check_tx_hang(tx_ring))
> > +			wx_warn(wx, "Real tx hang detected on queue %d\n", i);
> > +
> > +		head = rd32(wx, WX_PX_TR_RP(tx_ring->reg_idx));
> > +		tail = rd32(wx, WX_PX_TR_WP(tx_ring->reg_idx));
> > +		wx_warn(wx,
> > +			"tx ring %d next_to_use is %d, next_to_clean is %d\n",
> > +			i, tx_ring->next_to_use,
> > +			tx_ring->next_to_clean);
> > +		wx_warn(wx, "tx ring %d hw rp is 0x%x, wp is 0x%x\n",
> > +			i, head, tail);
> > +	}
> > +
> > +	wx_tx_timeout_reset(wx);
> > +}
> > +EXPORT_SYMBOL(wx_tx_timeout);
> > +
> > +void wx_handle_tx_hang(struct wx_ring *tx_ring, unsigned int next)
> > +{
> > +	struct wx *wx = netdev_priv(tx_ring->netdev);
> > +
> > +	wx_warn(wx, "Detected Tx Unit Hang\n"
> > +		"  Tx Queue             <%d>\n"
> > +		"  TDH, TDT             <%x>, <%x>\n"
> > +		"  next_to_use          <%x>\n"
> > +		"  next_to_clean        <%x>\n"
> > +		"tx_buffer_info[next_to_clean]\n"
> > +		"  time_stamp           <%lx>\n"
> > +		"  jiffies              <%lx>\n",
> 
> It's better to use a single string for the whole message, even if it
> would exceed the 80 chars limit
> 
> > +		tx_ring->queue_index,
> > +		rd32(wx, WX_PX_TR_RP(tx_ring->reg_idx)),
> > +		rd32(wx, WX_PX_TR_WP(tx_ring->reg_idx)),
> > +		tx_ring->next_to_use, next,
> > +		tx_ring->tx_buffer_info[next].time_stamp, jiffies);
> > +
> > +	netif_stop_subqueue(tx_ring->netdev, tx_ring->queue_index);
> > +
> > +	wx_warn(wx, "tx hang detected on queue %d, resetting adapter\n",
> > +		tx_ring->queue_index);
> 
> Possibly two warn messages for the same cause is a bit too verbose (same
> in wx_tx_timeout()).
> 
> > +bool wx_check_tx_hang(struct wx_ring *ring)
> > +{
> > +	u32 tx_done_old = ring->tx_stats.tx_done_old;
> > +	u32 tx_pending = wx_get_tx_pending(ring);
> > +	u32 tx_done = ring->stats.packets;
> > +
> > +	clear_bit(WX_TX_DETECT_HANG, ring->state);
> 
> It looks like every caller checks WX_TX_DETECT_HANG, it would be
> probably better to use test_and_clear_bit() here, and drop the test from
> the caller.
 


