Return-Path: <netdev+bounces-272614-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDjTHvKqxmk4NQUAu9opvQ
	(envelope-from <netdev+bounces-272614-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 17:06:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3994347216
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 17:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 442343017254
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 16:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C883133F8C5;
	Fri, 27 Mar 2026 16:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n2IEYbyr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FAC175A60
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 16:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774627543; cv=none; b=JoCCmOiI9S3yi8JhwB4bS4hXPwNpVyKoNmzc8HhZvfCgzOEBVmoAGVpMX0TSkQXZz55R1J315/8ADV0vVsXa7DSGBcoyvJwWfdMDn2NbHBA0JlEJE+OJvziPIymI0J9S7kLHZ8DIfFDFF3AhIB+I3KRrJKU2ICxwq/SEFINYBjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774627543; c=relaxed/simple;
	bh=P7+AT9Qtq+YhtE9wDKUqMb3C405IOWmHm3g29DxJWOA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KNCE5eVFsbsC1jUKN0LxFJgVrDwNUr8DRF+DQRNPkFmLN5uIckNd18eL0qBKpIGZhkg3zVDFjc8D2zke6wyXww2DPVQWnk7H89AnhLoSuqZMrf+hf8Hn9zDGuQLcCW3IEmZjLaZ0sfx2f4lFc4k3SipkvqsOg2RfkhwOJBZHuJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n2IEYbyr; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-829b7ed8964so2202423b3a.2
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 09:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774627541; x=1775232341; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VaBOH5smGjfDR55oWsIYX3v3uJHqDval+kOnHzpijTw=;
        b=n2IEYbyr9G8KxnkFYTqvIRg0Z7ypS1lSsszVfA7uWr/t+gZDZwb6aACIHwFIZmaut/
         iaNAFDcCi4grOIItyZIGPCreU53MhcCGY8dNqeTe2iVh1nKcQ9hl/7Owxd8Me0Qq/sgv
         gfSk7BxYFh6tAyXOYGpt6fqOs4XmZ7MvlbDRgL5vlQd+fmMYjUXHITX2XauOLeJzreMJ
         OJ7KMx6Q0EH8CHfRfZDcea2k06dQt4PX42E54sL/R14qN6hUO10Da7mnr2E+NvnCPQSR
         La5cE/+ICk8sInnbWzkN+xa+fm/y+DuB70QGERalODCvRT8wPboyIsTNHbwMAXCQ5cJS
         tCdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774627541; x=1775232341;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VaBOH5smGjfDR55oWsIYX3v3uJHqDval+kOnHzpijTw=;
        b=OaGcrIEKb+f0rjjpWQGw7pB3vdmfyp+p6E9k8Zl+vsLHh/TN4e5KGDqi9LhbIUjmO8
         TU25olO1PJ+HaZxjgQrYc/kQwltLZwxRD9xAj3WHXGrmxxGxROJInELZbM8VQdQSpDCV
         g93OGOoNTVboZIvguP10iQmvaRP6Il65iHKR/6mtdVOAXGZ1uLvEn1ooL3xsVcT2X8E/
         CCAE9mMYlGOGW/bwVWVocBHD5rG/Giz4ssagtLkMK0O4FX7n7TZUfwOBsPDZhyvNLSLd
         g9aLnywi8cpqlkdhO2+3kqDaNE/WPrydME0lFFcxsmuPT2NZ7Lxpmg0cLU94C/OuBLmr
         8f2g==
X-Forwarded-Encrypted: i=1; AJvYcCW29qt+28bgTzazmIwnZ6rjCjkEL8f7x/Rx2I1f4S7h26P65KL/QUnhsYQb4VvyjzOpggTvRpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbANWtVVu9Aptsys/CnC2Zdz0+vTgpk42K71rrpGD1j5z9iO2q
	xM3R2jaZ4b2YAqngYHhx4WMHE+ctuAtLiT3quzmq+2eyqE57ykVe+0OG8nOJwOlGRIRr+xLgEk2
	zx1b7eA==
X-Received: from pfhh9.prod.google.com ([2002:a05:6a00:2309:b0:82c:6a93:7b28])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:17a7:b0:81f:4dfe:ddd5
 with SMTP id d2e1a72fcca58-82c95e5ab97mr2801781b3a.4.1774627541410; Fri, 27
 Mar 2026 09:05:41 -0700 (PDT)
Date: Fri, 27 Mar 2026 16:03:50 +0000
In-Reply-To: <CA+jwDRk_pg6jLsg_nZ+DwHKcLk-TjbhS5o8aveOD5ns=yxUYCg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CA+jwDRk_pg6jLsg_nZ+DwHKcLk-TjbhS5o8aveOD5ns=yxUYCg@mail.gmail.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260327160540.3392203-1-kuniyu@google.com>
Subject: Re: [PATCH] rtnetlink: add missing netlink_ns_capable() check for
 peer netns
From: Kuniyuki Iwashima <kuniyu@google.com>
To: nickgarlis@gmail.com
Cc: kuba@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272614-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,aristanetworks.com:email]
X-Rspamd-Queue-Id: D3994347216
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Nikolaos Gkarlis <nickgarlis@gmail.com>
Date: Fri, 27 Mar 2026 09:55:31 +0100
> Hi Jakub,
> 
> I've created a crude reproduction script using some AI. If that helps,
> you can find it here:
> https://gist.githubusercontent.com/nickgarlis/5a5815d438aa19b409806712f35f2cb1/raw/c7e2dd0902f1f53f5750f7bbd3ba39ff0b21e43e/inject_iface.c
> 
> > AI assistant here suggests this is not the valid Fixes tag,
> > which seems true on the surface. This commit was fixing
> > cleanup, IDK how it could break input validation?
> 
> I went back to check and ran the test against 7a0ea70da56e (the commit
> prior) and it does seem like it was broken then too. I think I must have
> messed up my testing process when I initially submitted the patch.
> 
> It also seems like the bug was always there or at least - almost always
> - since Iassume it wasn't a problem before unprivileged namespaces
> were introduced ?
> 
> In that case, should the tags point to the introduction of the
> attributes (like shown below) or point to the introduction of
> the namespaces ?
> 
> Fixes: 0eb87b02a705 ("veth: Set VETH_INFO_PEER to veth_link_ops.peer_type.")
> Fixes: 6b84e558e95d ("vxcan: Set VXCAN_INFO_PEER to vxcan_link_ops.peer_type.")
> Fixes: fefd5d082172 ("netkit: Set IFLA_NETKIT_PEER_INFO to
> netkit_link_ops.peer_type.")

No, these commits just factorised the common part.

veth does not have the userns check from

commit 81adee47dfb608df3ad0b91d230fb3cef75f0060
Author: Eric W. Biederman <ebiederm@aristanetworks.com>
Date:   Sun Nov 8 08:53:51 2009

    net: Support specifying the network namespace upon device creation.


and vxcan and netkit does not have the check from Day 0.

