Return-Path: <netdev+bounces-294825-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HtpdE+1RIGro0wAAu9opvQ
	(envelope-from <netdev+bounces-294825-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 18:10:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B192263992E
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 18:10:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=S5mlReqE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294825-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-294825-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7633F30FEE74
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 15:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256243D75A5;
	Wed,  3 Jun 2026 15:58:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54DB3B585D
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 15:58:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780502286; cv=pass; b=uDZud6N4WEa/RrTzzHFqiqqb7R1digGCP59c7oS5TUNDb0/2c3gW9d+eT5c/ehPndEXNMaQVlnDSjHywEuMHJa+/26xYb6CyhHINFlDZz0kTGV2kVGSGkl3rPMYcmChX3gOgOqULX+UvNR4egJPisg4tIfaxWcUbzVV6RMkr+TU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780502286; c=relaxed/simple;
	bh=yL1+zSmYNp1KITQQnvlezBdoEXLPMQw57Tpy+kdNl8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VR9qKTlpnKU5ST8KP5p5i8QEK5LzAEavrUC1THiUcWniSBAM6jYZtpQnnHafvnKyCtXTBNy+1FF8zX0j362MLWYsZJA7R9y1PuRvrAL8qfHkdph1GiwNeRDnZWi6cSyjYEghtmTsmt3aR0A8eXXwinTUahdPlgHQjndyhR6qJqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S5mlReqE; arc=pass smtp.client-ip=209.85.222.169
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-9154ca1aa1dso120635685a.0
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 08:58:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780502284; cv=none;
        d=google.com; s=arc-20240605;
        b=lvXp2LGFxvFDBlitPxudbRIKM8lIXjq5nC8xdi+h1Ow7y93WgJiFF1K7w6G9+D4d1i
         cyNa76xmQJcavZ2XGWKf9M6A2NB4sQ+1cK1wQMYCFkIL4k5E8KTeQ2J/Wwvsc4QwZ7b4
         he2UPbL8bKGbhFCA7BavxNxu7T48/uJ49G1ifNyyG+VF5u6P5ofvn22nYuYMHE0QolCt
         98nCcYHhhA7kArj3a1QxLMq8mkM63PBc8WwdKT/uP2OiS+WsKAq3xB6K08kKy8py3GD5
         lB2GJfvR92LLIHyhHAQUAS7ZxtvMBtSzf1uLWSB/oIoMQTk8K8pFdKOtYU/H1pHzhWct
         Nphg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yL1+zSmYNp1KITQQnvlezBdoEXLPMQw57Tpy+kdNl8s=;
        fh=hsMXUG3672JREe4NDd3XUeeMnSK23Z+vn9EJ0Tms6Ko=;
        b=X1yXbxW3Z4x4Y5Xgba7lv6iGfKzkx1vbvFZf0hnFPbOZBciQ8g0gGSv55+kf++ArYX
         zMa191ODBqHUGI/+3b5KJQ6FBNp297hppbz7l53TEPWZ8J8WFTkMjomZ9MlM9YSwI1TG
         LQDxUWXdGqouzoHIEfxMIsDXtU143b/201iws5UYW16cdIrD2i+lIPtEisPwp9Mx9KB9
         zT6ctk61HiFmfPW63Z6FdlwZAD1aq4M4mKGeuykp8FAdkuuZ/wcvKf5haJV3O/LKSg8C
         9pHGv9r+4my4QgFecbCs5QLOHXCT6tvkoaweJ0FRpGPd+RAOuK8mT/wreb01W0POkkBb
         lKcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780502284; x=1781107084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yL1+zSmYNp1KITQQnvlezBdoEXLPMQw57Tpy+kdNl8s=;
        b=S5mlReqEKba3FRzuyhOO77vRW3nK65Uvzq0fl398mxHkDnoa2ywLHxolVbdZaFgqgQ
         HGs/jsSOgUx3dDQQ3uudmHVDbj8dG/VCQ0P7mI0kVXhpMFGC6MifRbD18RkpL8M1EMU9
         +/ZlvCAisBZ6x0kuIcoWANisHdwN5dII+Hn2LPOwzc3baFlThrNsEY7h8WGnG3T0yWt4
         JBJ4H2S4s1wX0kq3x5+S87VnP1qNouC0nVLV6T7WC5nmj+OEZt2sXTuBuu0y7IEx8KJ8
         cJwNfjks9qTjZ4R/cLL/ExVdDsKmC2ehcqH8CvCu8rf1f8WxsDkkFk7q2p/wCQ99IsmO
         gEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780502284; x=1781107084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yL1+zSmYNp1KITQQnvlezBdoEXLPMQw57Tpy+kdNl8s=;
        b=bmiVA6i3hl7ffQ8Umi2x6uzNKCjmrG8kTYr9bZ4GlfCiM9ZU1WhD6B7GPcX308EiYr
         lMfu6ZqiAMTSOZtXArlUZTkotnWy1eatz8/AxJs4hcolZKKPSUeiMJFDWM+JtECUzIIt
         c22yEfchK25paNBeZdfvPFrg6kVJ9NEF6TB3zQy+9Eqj1b1R0jSK0jVv2ucehgvVwlDn
         R5LbgF/pVnTYWZQYHYaea2ND+SW0hpGCB0i04XQxFz0hOWstJnNYvFx1yaABJz6U2LkX
         vB2SbfOKpo01EyMHfu80YrrmwPhET4rtAyvv36DdczVI1FUJSWgyO8R+zxQN2nm4yX85
         GsrQ==
X-Forwarded-Encrypted: i=1; AFNElJ/somsOJFmb9ZjP8qXp81wni9DiDSzkQyt3ylNOvBOq2rZd+I8TmzL5WrOuDDLHf6gHU5bRDMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwVwkRj9VPXNJEKYccHCsZRI/mEb8CoWZvZEc1I1TzYuuOX+T1
	Oz/IDozptYs2OkddHc3iG1/hDgjMpMreczmWen7h5zjD2iIpVKx0opD4IHfdJlmepdgDDvNKVTo
	Ta5hq2KFIvHEgG7eMEQP2OTiOvlR7uO/AiqBQBqDk
X-Gm-Gg: Acq92OGIPggbYeaWEt249oNUAKFwh3dioO+BM4zi6sNLBqHu9XGzBWGYyn4blJF3u/m
	Gju3Wtyf69cAzvAEs4Gl8/u39YseAkxT06JNJ5YpCs/Nnkn9t9dmSd1hbhBWNDpLnh2yhu1T2jG
	hR4t0dvWUQ0r/lHCvrE9Rl00nVB8OFrERMhVqH1g3uNrIwAe3qhTHKmOuK9LavqYQxG3laKEDee
	q5CzgRA5QRdXBBS9ijuo8n8mV435WZnAw799T5Nj+7Z2LCaX+fv6dHWN/m+MsMiF+yS6ZftDehB
	mvH7jzcKTHTMOpVdQ0AOyfhZEY9/2TDsbwKJZN8bW5P82g1DCSKbxhFwAtjvoSCVgRqg0srIy1x
	gTEo09D7Ekel44cEkrhTw77meaOXreg==
X-Received: by 2002:a05:620a:2684:b0:915:956a:71e3 with SMTP id
 af79cd13be357-9159aeb2929mr3185485a.13.1780502282476; Wed, 03 Jun 2026
 08:58:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603072955.4032221-1-edumazet@google.com> <87h5njzkyy.fsf@bootlin.com>
In-Reply-To: <87h5njzkyy.fsf@bootlin.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 3 Jun 2026 08:57:51 -0700
X-Gm-Features: AVHnY4LVcU-jeFD6SAYzloRoKp04UJg8VPsqBbdLcmxhzutK8gMTWWThS9Q7x9o
Message-ID: <CANn89iKObcLouP=nE1RvZmq1qWywkTrA9x=O871-7_FKiWsFyQ@mail.gmail.com>
Subject: Re: [PATCH net] ieee802154: 6lowpan: only accept IPv6 packets in lowpan_xmit()
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot+f13c19f75e1097abd116@syzkaller.appspotmail.com, 
	Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294825-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,syzkaller.appspotmail.com,datenfreihafen.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:miquel.raynal@bootlin.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:syzbot+f13c19f75e1097abd116@syzkaller.appspotmail.com,m:alex.aring@gmail.com,m:stefan@datenfreihafen.org,m:ericdumazet@gmail.com,m:syzbot@syzkaller.appspotmail.com,m:alexaring@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev,f13c19f75e1097abd116];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,bootlin.com:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B192263992E

On Wed, Jun 3, 2026 at 8:45=E2=80=AFAM Miquel Raynal <miquel.raynal@bootlin=
.com> wrote:
>
> Hi Eric,
>
> On 03/06/2026 at 07:29:55 GMT, Eric Dumazet <edumazet@google.com> wrote:
>
> > The aoe driver (or similar) generates a non-IPv6 packet
> > (e.g., ETH_P_AOE) and queues it for transmission via dev_queue_xmit()
> > on a 6LoWPAN interface (configured by the user or test case).
> >
> > Since the packet is not IPv6, the 6LoWPAN header_ops->create function
> > (lowpan_header_create or header_create) returns early without initializ=
ing
> > the lowpan_addr_info structure in the skb headroom.
> >
> > In the transmit function (lowpan_xmit), the driver calls lowpan_header
> > (or setup_header) which unconditionally copies and uses the lowpan_addr=
_info
> > from the headroom, which contains uninitialized data.
> >
> > Fix this by dropping non IPv6 packets.
>
> I am not sure I fully grasped the syzbot report. The problem may happen
> because an interface can be configured as a 6lowpan interface, which in
> this case should not transmit the packet, but there are other possible
> configurations which would just work and accept ETH_P_AOE packets
> (whatever that is). Is this correct? If so, then this indeed looks like
> the best approach,
>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
>
> But otherwise I guess this fix would totally prevent the AOE driver
> from working correctly, so I just want to double check my understanding.
Hey Miqu=C3=A8l,

Yes, this is only for when the interface is configured as 6lowpan,
which implies IPv6 traffic.

If it's configured differently (e.g., for AOE), then it shouldn't be
using the 6lowpan xmit path.

Thanks.

