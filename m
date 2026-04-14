Return-Path: <netdev+bounces-278336-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GE3vCoz53WlTlwkAu9opvQ
	(envelope-from <netdev+bounces-278336-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 10:23:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C09F83F72D2
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 10:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40D5430C603D
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 08:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBB237D10B;
	Tue, 14 Apr 2026 08:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jSVqOkwm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20426395D87
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 08:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776154673; cv=none; b=F8LaBI7zpFcbz1gsHwkI/Ah2zNXs4or84qVFynBSZ0y4sxRNbPvYWe+8axqFfzkgvbHNrmD8XD42uR12gtOcI5xJpPthmXk32bDZiBModGmnK4QvfI/yse4KHQOcz3BjERZUlUjZrylMyXhbWbh7jWIMGtgxfm12QI/SzKDUSCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776154673; c=relaxed/simple;
	bh=XjE3KvvtznhpXdXFKhTOSErSXtiBB+pq+vqAkXYd6hA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MdnV4oGrSWSeVgtjkDs88vk3Rml5OmFnw/0NM6Q+QUV8joBl1NKcF5QgtfE41OBTmq0HLo+kwaUvtwt3qoByUVLcvftlrkD2huQDpbsiqGBfesZIzlay5cEHDpqG7B0YDv+LqD2OUW17hixU+MO/ccDeYj3OKqVO3Yi1cd72RD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--nogikh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jSVqOkwm; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--nogikh.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b9c2bce2affso412199666b.1
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 01:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776154669; x=1776759469; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PpSRCnTePyac3ErNAs9VMd0eycUA9emlUIzGd/Q0QSY=;
        b=jSVqOkwmjeNR+St2KiAa7S6cpV4nXhh/n5R1ENanhL3hnvIhCMOJ9E7biThhprC7xy
         4Jd0+p01h5aWKAngGBdMw1Vm6/e/iY+UDc5KC2c8V97YtuzkF384HlXKGZ6OJR43yCtV
         snxDz6MNtjF5cw3YzXaGIlJwr0RlI/Pw/mOWwLGm8RWlpkhv7wky9YmrGn/EBC2M36rt
         mr5QyF2dc+40/GCX/T0cITKhGKzaNQUlvjDfgtIuU7iQl+YXeXkox+JyzLhVKiiD7swF
         Vqc436Sz7wIuvqSLwK6VjlzxGdDdXNjdv2sl2kKFeN/n9GudeIg51J1zMZMIHb61dGfG
         G1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776154669; x=1776759469;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PpSRCnTePyac3ErNAs9VMd0eycUA9emlUIzGd/Q0QSY=;
        b=L4WzVCQZbj2wgF3PSfpCdn2uMy84kftfmBQeZQe43E2lcUXNji4FbdVod5lOhq+CB5
         PW2k+1JVRhO3Wvq17kbGETV+nS/36eLxoJaEDbz9cUL2apmnL0cg8VW/Ra1fepDwOVPS
         xBDvm9hvFqvxaEd2HvHIflP/zNbLqZsR5uV25yIIQ752rqAy5npDBJ+62QD/2UVEO3JV
         4KFhDn3gpH5mnHfAYbVPcl4VidAr4lA6JGU63sG/bJELggEhz/4kl27Oo2Hdnwu+y7Bh
         JrrOTLQ0V9iKROds96Dwr+DE/0g+VKpjoJBEVbQiJGWq4P2dlMrogAYWyxXNBGcHkT3A
         RPwA==
X-Gm-Message-State: AOJu0Yw4N3ldYv/NExXg8aDE6TpaU+2hGLMKVlDeb7kRGPcTM5cHxiBa
	LpqCpajfsmW+W2zE5vU+MB+Z3t3anrhwPpzQjg38FFJCFnXmnVsLat4QeCFNTcoCa4X6OvfLibe
	WHas9fg==
X-Received: from ejcnb15.prod.google.com ([2002:a17:907:1c8f:b0:b9c:6791:7165])
 (user=nogikh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:1b1c:b0:b9c:4893:822e
 with SMTP id a640c23a62f3a-b9d72440894mr925158566b.10.1776154669125; Tue, 14
 Apr 2026 01:17:49 -0700 (PDT)
Date: Tue, 14 Apr 2026 10:17:46 +0200
In-Reply-To: <69dd48c2.a00a0220.468cb.004e.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <69dd48c2.a00a0220.468cb.004e.GAE@google.com>
X-Mailer: git-send-email 2.54.0.rc0.605.g598a273b03-goog
Message-ID: <20260414081746.17392-1-nogikh@google.com>
Subject: Re: [syzbot ci] Re: veth: add Byte Queue Limits (BQL) support
From: Aleksandr Nogikh <nogikh@google.com>
To: syzbot+cib904ea9ebb647254@syzkaller.appspotmail.com, hawk@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-278336-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nogikh@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev,cib904ea9ebb647254];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C09F83F72D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Hmm, just fixed a problem that may have affected `syz test` processing,
let's try again:


#syz test

---
  drivers/net/veth.c | 4 +++-
  1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 911e7e36e166..9d7b085c9548 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1138,7 +1138,9 @@ static void veth_napi_del_range(struct net_device
*dev, int start, int end)
         */
        peer = rtnl_dereference(priv->peer);
        if (peer) {
-               for (i = start; i < end; i++)
+               int peer_end = min(end, (int)peer->real_num_tx_queues);
+
+               for (i = start; i < peer_end; i++)
                        netdev_tx_reset_queue(netdev_get_tx_queue(peer, i));
        }


