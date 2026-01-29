Return-Path: <netdev+bounces-254783-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJIlKJRTe2nRDwIAu9opvQ
	(envelope-from <netdev+bounces-254783-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 13:33:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0085CB014D
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 13:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AE563011F23
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 12:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C07387352;
	Thu, 29 Jan 2026 12:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JRc05ImU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mk9aURxJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E6433A701
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 12:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769690000; cv=none; b=Q4iEBxQABvTh/uz4Wj3PebNEGzmuwtNSNBZ34ieKBjsPvCtL23Vk3gS18JeS3dfxJjj8H0zeD5LtHGn4XCf6RtuG+FeC3opYYDjyqRRBIlqCr7rEF/Zurfy6cUOFoxa0zgWmYSjBYLPquzIXOBFSPt37jdVczuPnqtB+Ycll5IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769690000; c=relaxed/simple;
	bh=40wMWG7SyPMSzabUx/Wcz8EBhiLCqDenQlqMLv7YPuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lErPA/ws5blXYaLhgPoHsq5hbObeJCQAJkrjEF3kCVcAjf2SQhsLQ/CjEloEM2tLkp0wH/UXDuqMeXrPvdtfV4VzGHNaVt9IHW+SCqARb+YnIJ68f7U+gd8ogxeMTqAGEQf8PSZN0NCoyIafZtZaCRML+gBcmChYzxKcp2dZq6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JRc05ImU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mk9aURxJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769689997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mRy+y1wqapOxzHZCLfyA/JeLGF66Z2ABQ1elBTYnVS4=;
	b=JRc05ImU/vL7Pjtmmk7Kr2D9muuhAEyVDQtzt4+kPIndEj0xufFgIq8L/gCVrFVHciDxBQ
	9nBC036TOivqMXPwSLiiTId9W+QR0603gUYxn8fF2qqLYiXDwttaONCvJE9+G7dM1YsBVe
	fAFsyREbeeKR5PpvIvd+vVbjsPzqAuQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-YLQMyGB-NKS8bLO-Hbyo1A-1; Thu, 29 Jan 2026 07:33:16 -0500
X-MC-Unique: YLQMyGB-NKS8bLO-Hbyo1A-1
X-Mimecast-MFC-AGG-ID: YLQMyGB-NKS8bLO-Hbyo1A_1769689995
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-435db9425ebso1020712f8f.1
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 04:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769689995; x=1770294795; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mRy+y1wqapOxzHZCLfyA/JeLGF66Z2ABQ1elBTYnVS4=;
        b=mk9aURxJGV5Dq4HkjScpt28cZRFybtpaKsqvMq86MJGFicSZRH7U2kHlKCkhNFYYY4
         TypZ+qGfVPLUC0BgfhQWUGmeTWzGHMM8/VZIWOKVqGCP2PWWIksfNXGBCVXh0fztblYe
         jHi0+rWjU4yOv3YW7r5etnAxQAZCpDt5VoQALw5XBkkf9wmTDchKHvl6awpZgijVA0rx
         8aKx4MxlaO1Nju0G/lHYYloQhaH+UJY658JHbUgCI50FcIJkAyoRDcDv0wjLRQwZC1io
         isHZFBRRbLZqDS6GJ1rYYtEO3mFoCGklfO54RfMMkDpf5PPBrRHt4VUHTkbGphHFtY2P
         sW7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769689995; x=1770294795;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mRy+y1wqapOxzHZCLfyA/JeLGF66Z2ABQ1elBTYnVS4=;
        b=bCcAduON/2TImNpBq8kidOmSyYC0DEc0XNsQOo2wurLgaa42LOIU0dF+wEpqnAE5U/
         lRXvmKoCGtOo6vCLsQgkm127DT4de/lwTT/csx3RMY5tinm1FaNoSyt6ApuBCL8DTRQJ
         EoQmUW625oINDQU+pehPjlt4S58ox8JNIFavE+BRoZkd4hfiwGZP70v0I/c+5zjW34tX
         KyRKi3kqjkDqIbJ2p+hvrvDnKFyUdVgCL0pSVmpqzCX5EtF6M1e/I6sLwWeJ1jeBdHC8
         DHRrp0yPDBNE7oNTHPBMjc38tKSK02vHRf2oWFLmB+NWaO0W5p3h6qk6TGPcpyNxd5iU
         TFnA==
X-Forwarded-Encrypted: i=1; AJvYcCUBm/OLznn6ow20hLmsH9gUHcJZC7VdX4QEP58oBU+yZNJJOkRb9YEMPzBJPHMhmCZI1O2UOYk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/rcROiKBUmSjxWhBnazYA0puak5NDx1lPRh5ADxdMNU++E3Md
	vcohExTBtjfGxHtjumND086EAUYZG+HfAVIMyUEwcPY71ffmOd607B8xFSl/CSihV6TEPQJ6ife
	VoOxCJJy578qLR54uY9FQDl4GQxl9lw1wARkr2vDDp4Pohu9AKDHOzBbK9Q==
X-Gm-Gg: AZuq6aKxag/KPefstfyw2Ee1aR+mdkQeh9EvOzwGnv6tIDU1TpzoPct6caGUOSM7hol
	4g0GQveQFJrb195Onx4CMUrbSd/GADtPdL8Vuohcpt5WjgmGtULuYVMc6rF6LBRHJl5vGUFDhIa
	tH6wXWYqmCWrctQlPqafYeFd01jGeS6vkrQ9gFvYIX7m+1DoGnskXY6fzQskZxBwudl3yVt3+7f
	uJbWfPyQVVDMhjQE7i6fFq7ZDzOurX8zfEeKm/7DSn1xmM0FJqxEBfta5YY0ySRLIsmPZ1h0Bo5
	u2Y6Vp0cNw5pTbEx5OqyfAozgDJm87u6SJEv/4mqaY+4uu1JPm3yjbAiTe37228u2w3dDT62m4J
	pKba7LId8PJMu
X-Received: by 2002:a05:6000:22c9:b0:435:9882:234e with SMTP id ffacd0b85a97d-435dd1d8e62mr10552735f8f.59.1769689994920;
        Thu, 29 Jan 2026 04:33:14 -0800 (PST)
X-Received: by 2002:a05:6000:22c9:b0:435:9882:234e with SMTP id ffacd0b85a97d-435dd1d8e62mr10552677f8f.59.1769689994350;
        Thu, 29 Jan 2026 04:33:14 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e132356dsm15075716f8f.33.2026.01.29.04.33.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 04:33:13 -0800 (PST)
Message-ID: <9621f01f-5c89-4d13-9997-b4066b7e9d16@redhat.com>
Date: Thu, 29 Jan 2026 13:33:11 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 07/15] quic: add connection id management
To: Xin Long <lucien.xin@gmail.com>, network dev <netdev@vger.kernel.org>,
 quic@lists.linux.dev
Cc: davem@davemloft.net, kuba@kernel.org, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Stefan Metzmacher <metze@samba.org>,
 Moritz Buhl <mbuhl@openbsd.org>, Tyler Fanelli <tfanelli@redhat.com>,
 Pengtao He <hepengtao@xiaomi.com>, Thomas Dreibholz <dreibh@simula.no>,
 linux-cifs@vger.kernel.org, Steve French <smfrench@gmail.com>,
 Namjae Jeon <linkinjeon@kernel.org>, Paulo Alcantara <pc@manguebit.com>,
 Tom Talpey <tom@talpey.com>, kernel-tls-handshake@lists.linux.dev,
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Steve Dickson <steved@redhat.com>, Hannes Reinecke <hare@suse.de>,
 Alexander Aring <aahringo@redhat.com>, David Howells <dhowells@redhat.com>,
 Matthieu Baerts <matttbe@kernel.org>, John Ericson <mail@johnericson.me>,
 Cong Wang <xiyou.wangcong@gmail.com>, "D . Wythe"
 <alibuda@linux.alibaba.com>, Jason Baron <jbaron@akamai.com>,
 illiliti <illiliti@protonmail.com>, Sabrina Dubroca <sd@queasysnail.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Daniel Stenberg <daniel@haxx.se>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>
References: <cover.1769439073.git.lucien.xin@gmail.com>
 <ad730679ce27da0886104546a3d327b5fb653340.1769439073.git.lucien.xin@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <ad730679ce27da0886104546a3d327b5fb653340.1769439073.git.lucien.xin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254783-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,samba.org,openbsd.org,redhat.com,xiaomi.com,simula.no,vger.kernel.org,gmail.com,manguebit.com,talpey.com,lists.linux.dev,oracle.com,suse.de,johnericson.me,linux.alibaba.com,akamai.com,protonmail.com,queasysnail.net,haxx.se,broadcom.com];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0085CB014D
X-Rspamd-Action: no action

On 1/26/26 3:51 PM, Xin Long wrote:
> This patch introduces 'struct quic_conn_id_set' for managing Connection
> IDs (CIDs), which are represented by 'struct quic_source_conn_id'
> and 'struct quic_dest_conn_id'.
> 
> It provides helpers to add and remove CIDs from the set, and handles
> insertion of source CIDs into the global connection ID hash table
> when necessary.
> 
> - quic_conn_id_add(): Add a new Connection ID to the set, and inserts
>   it to conn_id hash table if it is a source conn_id.
> 
> - quic_conn_id_remove(): Remove connection IDs the set with sequence
>   numbers less than or equal to a number.
> 
> It also adds utilities to look up CIDs by value or sequence number,
> search the global hash table for incoming packets, and check for
> stateless reset tokens among destination CIDs. These functions are
> essential for RX path connection lookup and stateless reset processing.
> 
> - quic_conn_id_find(): Find a Connection ID in the set by seq number.
> 
> - quic_conn_id_lookup(): Lookup a Connection ID from global hash table
>   using the ID value, typically used for socket lookup on the RX path.
> 
> - quic_conn_id_token_exists(): Check if a stateless reset token exists
>   in any dest Connection ID (used during stateless reset processing).
> 
> Note source/dest conn_id set is per socket, the operations on it are
> always pretected by the sock lock.
> 
> Signed-off-by: Xin Long <lucien.xin@gmail.com>

Acked-by: Paolo Abeni <pabeni@redhat.com>


