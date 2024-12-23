Return-Path: <netdev+bounces-154086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DB19FB3E7
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 19:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 722061884274
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 18:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9101B6CFE;
	Mon, 23 Dec 2024 18:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3PVAK/It"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829B11AF0AF
	for <netdev@vger.kernel.org>; Mon, 23 Dec 2024 18:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734977910; cv=none; b=NATX6jJgx4Q6obD+N4306Q4WYDVdKno1NEszfHFcxnmGuROOPx+m0SVwAiTh6BV/PVEyTdoAeeOpo+VEubm9aBsQcjBdEPSNP3yJM9+UtDjngi2vivEowvB2F4Vem77QcbVGsCjw+Ry5XlK2OwxwKXRJkm55ayIE/lQkXJNejDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734977910; c=relaxed/simple;
	bh=lpnuE1jy6D5B1C8YqIEawHAWQg8oOCJbsgJn1eOjVCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nzsgsWAaEL8fcbWEhoP0TjsiW20KWOUlG1qB6AaAD9BPHaCYEHKzjQUai6pWkxCTzqaS0l4/4kgWl++XyNzfh18KJSaefY5pXARiu+Mgoqydly8T6U6nBoISOyCEguaG/kqAtKJ3d7B4G1TGjHpSh50lzi9PzEgHVB6O+9jL6qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3PVAK/It; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d3e9a88793so7690497a12.1
        for <netdev@vger.kernel.org>; Mon, 23 Dec 2024 10:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734977907; x=1735582707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qD67mmuaryZoO7BAOBph9mkBchg5ceh364DO582hw80=;
        b=3PVAK/ItcqZa26WN7mIzsD0wTOR1oVC+LDq+6HqMZzt3ZBoujNWY4fdFqCgxBlT55i
         UbPWdyojtj1UiGKpsGwk2fLpcpXuJV3P92sXMsCSMgFVeHuW1uQ14nQDXXEDbWdc2VzV
         Bj1qRn/eblLtUCOJOIKbI6oMSyyzo3zNCd5T6C8CcFxRD0/LzyruXhDL/1Gkj+wGJEtH
         zJqx9+eZglAWTVtYeasfm1efoeOAzvcawJicjQ8LNEAWU32SmjVh5cJhj68JJJG3KE5D
         v5XAxNAjCaz6lcWW2J1VXa6QCr6dgYwuF4a1mxRKaDGJwJSdGUsx/xtE2xyv+LPV/n85
         lxhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734977907; x=1735582707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qD67mmuaryZoO7BAOBph9mkBchg5ceh364DO582hw80=;
        b=OO6b4ptQXz5xMkeDY41895CXZ2PGKRhCno8TzE7qNibNE1SYyVuFh1E20i617FKYal
         fEUqTkMBejT+r33YVZKyDXv+oBv6L7lEa1a2WPWOwy6b9hhuRdR88wk+cf+xWRugsQAp
         PvHId4CzYpKVHDjaj4sC6AF8yLCK+ThClixgymE1ycKKaNGU4TVBrAr4GP11Ez687cAg
         IIWp8ORSq5z6r3xCXRf5ubMWmCdAy8ubPvYsDUKlqe0uTZSFVUA3EpN+7Gs5fj5ot26g
         vOEOBFTFV+FKGZjs/oU4DlNdVKSsy6JNEjoZ3sQg7RKdfJYadHRMTMf18Bza11kVO8C4
         2zgw==
X-Gm-Message-State: AOJu0Yzvf22HKcMMTqKBk6duWW5GG34ZUGWQIXAIxVnTLuk5sieauWPt
	9fgueiC4Eheu0g8kvP7b+sHhFRkqlHOcKqaWEZUOLVGkHDTt/NJjVASLwRHCvrSF9Er2skVM8qQ
	cWasy+k1riaXOWNyAnBEXnVMTdX0po3GcdPyR
X-Gm-Gg: ASbGncsPcWvB89FMtMrWiB9gtbQD1Xq/dFJjePGNCXIYlInIW5Gr4fm9Lwm43teFRTf
	EmJrQm+HFrJUWamCfRHZf53uP/W+uEn2liItL3So=
X-Google-Smtp-Source: AGHT+IHQhbRrMopvne7+h0uqhHqKPoLZlJFQBccHFEcTxF5WS4xxeexjHGSvAwiPgBylWoNgc4u4khKiySrsVRVEQKE=
X-Received: by 2002:a05:6402:43ce:b0:5d3:ec6e:64bf with SMTP id
 4fb4d7f45d1cf-5d81de2dc4amr12211238a12.34.1734977906692; Mon, 23 Dec 2024
 10:18:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241220142020.1131017-1-antonio.pastor@gmail.com>
 <20241223133915.2333146-1-antonio.pastor@gmail.com> <CANn89i+9Lt78ErDdbgVuOgvSy=UBz2Vhnp=cJYGvwuuQLp6qjg@mail.gmail.com>
 <c8145fd0-df13-4c6a-8678-fbf9547cc112@gmail.com>
In-Reply-To: <c8145fd0-df13-4c6a-8678-fbf9547cc112@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 23 Dec 2024 19:18:15 +0100
Message-ID: <CANn89i+jk=OWS3L1OV-aVbeO85eU6u6yK=FRoRadNEihpAOcHQ@mail.gmail.com>
Subject: Re: [PATCH net v2] net: llc: explicitly set skb->transport_header
To: Antonio Pastor <antonio.pastor@gmail.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, horms@kernel.org, 
	kuba@kernel.org, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 23, 2024 at 6:00=E2=80=AFPM Antonio Pastor <antonio.pastor@gmai=
l.com> wrote:
>
> On 2024-12-23 08:54, Eric Dumazet wrote:
>
> On Mon, Dec 23, 2024 at 2:40=E2=80=AFPM Antonio Pastor <antonio.pastor@gm=
ail.com> wrote:
>
> 802.2+LLC+SNAP frames received by napi_complete_done with GRO and DSA
> have skb->transport_header set two bytes short, or pointing 2 bytes
> before network_header & skb->data. As snap_rcv expects transport_header
> to point to SNAP header (OID:PID) after LLC processing advances offset
> over LLC header (llc_rcv & llc_fixup_skb), code doesn't find a match
> and packet is dropped.
>
> Between napi_complete_done and snap_rcv, transport_header is not used
> until __netif_receive_skb_core, where originally it was being reset.
> Commit fda55eca5a33 ("net: introduce skb_transport_header_was_set()")
> only does so if not set, on the assumption the value was set correctly
> by GRO (and also on assumption that "network stacks usually reset the
> transport header anyway"). Afterwards it is moved forward by
> llc_fixup_skb.
>
> Locally generated traffic shows up at __netif_receive_skb_core with no
> transport_header set and is processed without issue. On a setup with
> GRO but no DSA, transport_header and network_header are both set to
> point to skb->data which is also correct.
>
> As issue is LLC specific, to avoid impacting non-LLC traffic, and to
> follow up on original assumption made on previous code change,
> llc_fixup_skb to reset and advance the offset. llc_fixup_skb already
> assumes the LLC header is at skb->data, and by definition SNAP header
> immediately follows.
>
> Fixes: fda55eca5a33 ("net: introduce skb_transport_header_was_set()")
> Signed-off-by: Antonio Pastor <antonio.pastor@gmail.com>
>
> Thanks for your reply.
>
> 11 years with this stuff being broken...
>
> It works great without DSA thrown in the mix, for some reason I have not
> been able to determine, not for the lack of trying. Wonder how many
> configurations use DSA and care about SNAP frames.
> DSA was added recently to the implementation I'm working on, so for
> practical purposes this is just broken since 1-2 years ago. Tripped on it
> about 6 months ago. It's fresh. Or well aged. :)
>
> I wonder if we could remove it from the kernel, given nobody cared.
>
> Well, at least I do, and ballpark 40 other people for what I can tell.
> Some others might be lurking in the sidelines.
>
> Can you at the same time fix net/802/psnap.c,
> snap_rcv() is probably having the same issue ?
>
> That's how I got here, because of snap_rcv(). But no fix is required at
> snap_rcv(). This patch is to fix problem there.
> snap_rcv() doesn't advance the transport_header offset or pull the skb as
> far as I saw so adding a reset there, that would be redundant. Once
> this piece of code determines LLC header size SNAP header always follows
> for SNAP frames.
> I'll double-check and submit a v3 w/that included if I think it makes
> sense but honestly I don't think it does.

I see skb->transport_header being advanced at line 61 :

    /* Pass the frame on. */
    skb->transport_header +=3D 5;


Note that setting the transport header (conditionally or not) in
__netif_receive_skb()
is probably a mistake. Only network (ipv4, ipv6) handlers can possibly
know the concept
of transport header.

Hopefully at some point we can remove this defensive code.

diff --git a/net/core/dev.c b/net/core/dev.c
index c7f3dea3e0eb9eb05865e49dd7a8535afb974149..b6722e11ee4e171e6a2f379fc1d=
0197dfcb1a842
100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5474,8 +5474,6 @@ static int __netif_receive_skb_core(struct
sk_buff **pskb, bool pfmemalloc,
        orig_dev =3D skb->dev;

        skb_reset_network_header(skb);
-       if (!skb_transport_header_was_set(skb))
-               skb_reset_transport_header(skb);
        skb_reset_mac_len(skb);

        pt_prev =3D NULL;

