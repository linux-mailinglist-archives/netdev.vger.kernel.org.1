Return-Path: <netdev+bounces-235422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D858DC304EA
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 10:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F433421852
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 09:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2BF2BCF41;
	Tue,  4 Nov 2025 09:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y/IMITft"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AFE2C324D
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 09:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762248505; cv=none; b=AZ3RfRy2k5FoBXyUAWGvrTPzX8S42sAjtJg+9t6IjOS/CsAd7GQabzh99uBNNgp/EXUos9gJbhD56m0/Nzj6WokB0vTd201BZ1GzPSY4AAYwhHEirQAq+ZmfcH9KA0dBzeJEZfpX6KtR+ndjBI50BZEwoizqO5jLyEWKcVkr6Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762248505; c=relaxed/simple;
	bh=FHiaQB8dkhlKzijHAIxD9g1bXh6dj1dMF5lAHPTH2Ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MrLRa9i4T1I+K5uR3ateoS+GmlCkSjJBQ4upl61xp7hz4i2SCTksmlxIArTRgjicS6UZ9LmSytRp6plODr5y7rksDnQSKcCJcWrZ2dDO5IJvT1CJHNE7EuF/NkQnf+eH9wfWC5g9xprqOc8TlDlY8p0IkgvB+Edy+OfhfkuHDao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y/IMITft; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762248502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yQFv1OAs06HmUQpyPU8NyiNImlb6aieKdzgbQcZa9yQ=;
	b=Y/IMITft8Q/sty4aRzsXo6mmgyxBeU0j72L8Vzf2kF3vZNmGEp0rVK3r1puqekIWVYE2Kk
	WFqsFVw5pRUQNaEEVr0o2Wvr2Gu+8L7Y2RQUfDQCB3/6UC8ZUAw/yO6W/1EUcv7xpb/dkN
	uglsxWD3XTv82W56iUw8PuRd3qGo1io=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-yc2K3xmtPd-RIzQwEh0PMw-1; Tue,
 04 Nov 2025 04:28:17 -0500
X-MC-Unique: yc2K3xmtPd-RIzQwEh0PMw-1
X-Mimecast-MFC-AGG-ID: yc2K3xmtPd-RIzQwEh0PMw_1762248496
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7FC9F1956053;
	Tue,  4 Nov 2025 09:28:16 +0000 (UTC)
Received: from localhost (unknown [10.43.135.229])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5E49D30001A1;
	Tue,  4 Nov 2025 09:28:14 +0000 (UTC)
Date: Tue, 4 Nov 2025 10:28:19 +0100
From: Miroslav Lichvar <mlichvar@redhat.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next v2] wireguard: queuing: preserve napi_id on
 decapsulation
Message-ID: <aQnHMyJYU4kuCWCf@localhost>
References: <20251103103442.180270-1-mlichvar@redhat.com>
 <CAHmME9qcj=zHHm0-gTeSLxqwufEBFO721ciYQODTws6wTb7+Rg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHmME9qcj=zHHm0-gTeSLxqwufEBFO721ciYQODTws6wTb7+Rg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Mon, Nov 03, 2025 at 05:00:19PM +0100, Jason A. Donenfeld wrote:
> On Mon, Nov 3, 2025 at 11:34 AM Miroslav Lichvar <mlichvar@redhat.com> wrote:
> > +       } else {
> > +#ifdef CONFIG_NET_RX_BUSY_POLL
> > +               skb->napi_id = napi_id;
> > +#endif
> 
> It looks like io_uring has timestamping on tx, not just rx:
> SOCKET_URING_OP_TX_TIMESTAMP -> io_uring_cmd_timestamp ->
> io_process_timestamp_skb -> skb_get_tx_timestamp -> skb_napi_id

That doesn't seem to be reachable. skb_get_tx_timestamp() calls
get_timestamp()->skb_napi_id() only when the SKBTX_HW_TSTAMP_NETDEV
flag is set, which is done only by two drivers (tsnep, igc) and only
in the RX path. Using a tx_flags field for RX is slightly confusing.

> So are you sure this should be in an `else {` block?

Yes, at least for the use case with the timestamping option I'm trying
to fix. If it was outside of the else block, it would be copying the
sender_cpu field of the union (used by XPS). Maybe it would make sense
to do that too, I know nothing about XPS, but in that case the value
shouldn't be read by skb_napi_id(), which is enabled only by
CONFIG_NET_RX_BUSY_POLL.

-- 
Miroslav Lichvar


