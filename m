Return-Path: <netdev+bounces-269043-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LwOIZC3umlWawIAu9opvQ
	(envelope-from <netdev+bounces-269043-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 15:32:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B52D2BD313
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 15:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D847B3069E55
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 14:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A67D38A71D;
	Wed, 18 Mar 2026 14:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EAvdBn3C";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EHF9zPup"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6D9244684
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 14:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773844130; cv=none; b=uQ56V9DHC/xiwncEe6QC0ld2DuSaln+SKNE1ScRK8G7SlhvFOtil8S0Hnj93wNTczoGUrMMRosHYlOrJWjHs9DNBpS1aPZm05E3UfG9zn1VJNJRjybHhiVCMcCn5XOqAH016LyLxgbkV2r/9Sb3Ue5DI+17H/UdLBl+aRHBPoTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773844130; c=relaxed/simple;
	bh=V/FFUTNtBe3ZHFebRfpCVVXKR/AaoIAhlO/E02rp4Ow=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MhWHiKHYa19zfdvO7KgACBcplfEw1jww67SHj0tvPRREdl45K6HCfZmkV9pe51E4NnyxgAHu7icE7Nowd99SgBA7r20k1Cs3LAvMO4BSRWc8SelIFkHJomXSLn3bPxFmRKB5XpOBd6+oRRHX5CxEIcF/d9kJvkA21fP9M/7G4Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EAvdBn3C; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EHF9zPup; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773844128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V/FFUTNtBe3ZHFebRfpCVVXKR/AaoIAhlO/E02rp4Ow=;
	b=EAvdBn3CZUfQ09wMxBH76CT8q6r53bqD8ZiO2BNiFnlVGHE3AkWhvaheOkVsUKWuKsDk3d
	I23I+5iEpmJHMbxlqXhpZzHKlDEm4IjGjg2MuOKA/M3N2aD1JuJpATEaoEGTxzQP8scDg5
	1+j8zKAVxEozaRwKdBsbPD92ehNYZMQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-pWlup0o4O82HYAyLiS8uJw-1; Wed, 18 Mar 2026 10:28:47 -0400
X-MC-Unique: pWlup0o4O82HYAyLiS8uJw-1
X-Mimecast-MFC-AGG-ID: pWlup0o4O82HYAyLiS8uJw_1773844126
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4853f33b7dbso61225725e9.3
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 07:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773844126; x=1774448926; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=V/FFUTNtBe3ZHFebRfpCVVXKR/AaoIAhlO/E02rp4Ow=;
        b=EHF9zPupGLlCZZphdl2ytQCInUF5vBk+tMkE9RV3eEpfNHHXB2qUmhXNrIl6umq36o
         sRmPtBOX8SJBieWdd+Lr/1JM6U3029/a/GyLFug4K+RDzW6EA1b3Jfw3lXe1XNO2MNrO
         XVwwnf8eyv6ZePXK9JIu98vEeHxraixAepBnO7T0CIh7wiUc7cG8/5E4Hhajl6l5PqTu
         7WRkbx8UUcB4as3goEcqw8KhXXDEJzt/1VuRtSZ9VEZo+PX2iQBJmLlQjrRufRJGGblW
         T4F9jn5QjoOEo6A1AUMTBRAjs0vFNPwQMUiBAwhoHzSaaDXPAWj+wyodZTBBGF+ysM1k
         JFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773844126; x=1774448926;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V/FFUTNtBe3ZHFebRfpCVVXKR/AaoIAhlO/E02rp4Ow=;
        b=QYsvDuu98AtkWVgnb89Yvu+41IL2DhlIkF2Jk1SLzfyRsgk3qDYk8ny93xJYqenQHd
         TvaiXL/eSdwi761ycefFk1SzfOUNgvnEtMfI6b76F5vFnOFEKGVsyQc05noNsbclBhZV
         QhxrXaVBwbMKDVheRB1OqbW/88B71nBm0gum5kpGafYz0ozEVDzIxIA/1z/BOS7MRNI5
         3G7kKC8OEoIsHJiaLp/HCqb5/ItVO0lxeAFTic9K1327fKddkJo+Ycfc5GgqKLgeyW/G
         MGggWz/ZYhIJ8QT/b5aREL+Er3njsneT6n5b3q2j7QSu6/XAUq0nkUsobMik9fZb1v88
         pkJw==
X-Forwarded-Encrypted: i=1; AJvYcCUVFatpFy+AoBpiSDYlLsTYwHv8PhMv8ZW30gSEU7L1iyR1G8oN7ut1NKn30VTEIa0E8tyiGiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeKWfpnyw1CWV7NVtoNAuVzVkViJv2k04dyT6wJYVeTDYIg/fc
	fauZK99xpZKQ4nWAwMU88oGOeer9ix96poqqLETqIiYvNa3vNXNk7N2AXPc9/FY59eu/GURL0k9
	vPynPyuwCL/PvHbjGue7WwvdhoR2mzm61j/7cSNp6wcyrTj1U0/JNJguxCA==
X-Gm-Gg: ATEYQzz7OGUVnzP1guW3gW3klfw88p1LTSMhAAmG6TUPvqOVnBipx7vwB4XnK/JAWgY
	JVTfCJEbRdzZ1f3ktR9M67ZdFMlQ/nqeHq73iI6o16i0BGZDLLJ5c+YnRoNFsGdvlKpHGlglrLz
	umcJIcCOJy4N9viUWzL8lBWO1CEvUjdPOB237/AtaZj+psLWlD/x8dmIjgynKvuUAaX6lGTaXm9
	lJxxxm68MB+6wkMFEiDdiXV85YQjvwWkyyy6GAfuel4LP7Imys2+Uia6WUfsFPjxDyxERBtGsnC
	8qzYJDf9qL9gPgWnFkbhaWpmsBXRCCKt/cCitb0LsPdqqV21W1a9IP8J2HXIaN8NHknBvO3J48y
	As7A9JqI5zyD9cxP+0Zr4oVK9MfUAjKDpVUBz2nxyrEnFXJlQ
X-Received: by 2002:a05:600c:470f:b0:485:3baa:af14 with SMTP id 5b1f17b1804b1-486f44410acmr60861965e9.18.1773844125626;
        Wed, 18 Mar 2026 07:28:45 -0700 (PDT)
X-Received: by 2002:a05:600c:470f:b0:485:3baa:af14 with SMTP id 5b1f17b1804b1-486f44410acmr60861335e9.18.1773844125148;
        Wed, 18 Mar 2026 07:28:45 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea8fb0dsm270251795e9.3.2026.03.18.07.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 07:28:44 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 696805A31BE; Wed, 18 Mar 2026 15:28:43 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: hawk@kernel.org, netdev@vger.kernel.org
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, andrew+netdev@lunn.ch, horms@kernel.org,
 jhs@mojatatu.com, jiri@resnulli.us, sdf@fomichev.me,
 j.koeppeler@tu-berlin.de, mfreemon@cloudflare.com, carges@cloudflare.com
Subject: Re: [RFC PATCH net-next 2/6] veth: implement Byte Queue Limits
 (BQL) for latency reduction
In-Reply-To: <20260318134826.1281205-3-hawk@kernel.org>
References: <20260318134826.1281205-1-hawk@kernel.org>
 <20260318134826.1281205-3-hawk@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 18 Mar 2026 15:28:43 +0100
Message-ID: <87ms05nrdw.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269043-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[toke@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.871];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,toke.dk:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0B52D2BD313
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

hawk@kernel.org writes:

> From: Jesper Dangaard Brouer <hawk@kernel.org>
>
> Add BQL support to the veth driver to dynamically limit the number of
> bytes queued in the ptr_ring, giving the qdisc earlier feedback to shape
> traffic and reduce latency.
>
> The BQL charge (netdev_tx_sent_queue) is placed in veth_xmit() BEFORE
> veth_forward_skb() produces the SKB into the ptr_ring. This ordering is
> critical: with threaded NAPI the consumer runs on a separate CPU and can
> complete the SKB (calling dql_completed) before veth_xmit() returns. If
> the charge happened after the produce, the completion could race ahead
> of the charge, violating dql_completed()'s invariant that completed
> bytes never exceed queued bytes (BUG_ON).
>
> Whether an SKB was BQL-charged is tracked per-SKB using a VETH_BQL_FLAG
> bit in the ptr_ring pointer (BIT(1), alongside the existing VETH_XDP_FLAG
> BIT(0)). The do_bql flag from veth_xmit() propagates through
> veth_forward_skb() and veth_xdp_rx() into the ptr_ring entry. On the
> completion side in veth_xdp_rcv(), veth_ptr_is_bql() reads the flag to
> decide whether to call netdev_tx_completed_queue(). Per-SKB tracking is
> necessary because the qdisc can be replaced live (e.g. noqueue->sfq or
> vice versa via 'tc qdisc replace') while SKBs are already in-flight in
> the ptr_ring. SKBs charged under the old qdisc must complete correctly
> regardless of what qdisc is attached when the consumer runs, so each
> SKB carries its own BQL-charged state rather than re-checking the peer's
> qdisc at completion time.

It's not completely obvious to me why BQL can't be active regardless of
whether there's a qdisc installed or not? If there's no qdisc, shouldn't
BQL auto-tune to a higher value because the queue runs empty more?

-Toke


