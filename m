Return-Path: <netdev+bounces-218736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB1FB3E22A
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 14:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE7533B0C83
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 12:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9C1257453;
	Mon,  1 Sep 2025 12:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rfndXf+t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42214242D9F
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 12:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756728281; cv=none; b=Ug2h/C75Fs0JfUvHQD07v/b02dzGzJLFU3aPBXWn/OtXMKTWRx1JaNeMEADFux/jg87jwP0Kify1FwOnUfwVLNb7P2q2t6hjRbTIj8LDMe3YjR3X9/QxP4rNoCrWbH4oG/pz6i4BPNZHDE4uWdtr4ClkJmupx9qKcb80LRtPO+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756728281; c=relaxed/simple;
	bh=ZAL4JSbuGN7clEILizrJP1aCe+7lS+wzK3j/u4WwUm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jOMf+E3Zetb7WxH+J8vhuyvJXkBbZs+f/TCJdmbisxEQzRO0zY/XTGPBNpOrVSzu8gvsJgO51WavevBPiqzV+Wksa5TskwWrN2kmLNz4qESiFhyYq50w4/zARXe03NzoaMci19aoeefmn1fWAZiHPF5dwfh3CKER+VTmmyDumKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rfndXf+t; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b33032b899so7581891cf.2
        for <netdev@vger.kernel.org>; Mon, 01 Sep 2025 05:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756728279; x=1757333079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0m5TaZOBG6hNhsJncSaSdhQCERlDKCkltKeD46o2PQ=;
        b=rfndXf+t9tuwllloodMfUS+XSqC/D1Deu4jtXhNV6CqJy7aToaVt7DyE7K9qrnHSeT
         QXc+6POhdlVuaCaEHLolCbfwrR6zshz2ZxkLrulbbZoPgnl+JsRIrkr8aLB7UtCgrebK
         hh4k8Id8TqE1CmwWsuNuQtzGt/F457Gz4qILkaQ9h+yN6g3dGtwY9cNlhH9qji5ZZu0j
         9dFVFKlUBygbNnjSp+GU/NYettnNP3N/cd40c8RP11D9Yq7hHx25RueW5+op2mWZ7/2x
         yLXW93RoeaYwOgGUTa+x9oYC/ym58ai+4FaJGapevbvb6SV02CK09PPHzP2gz+MsRU77
         xJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756728279; x=1757333079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l0m5TaZOBG6hNhsJncSaSdhQCERlDKCkltKeD46o2PQ=;
        b=rkS8Lx9wC9rmL58VsywG5t2MLA+h6SXWBD4QKdx4zj0rNu74iucrdNK/JOA264OJAA
         nHP9OEXxGCFUhzcpJLnSYj/f9LXLYOlryFaeX0KgtsJiDTDxXaQO07Xu6uTXUlBaKe3m
         E633ta+s4Ble7TJhfbk2lzdoUwLhj5WaP3Zr4SBu6kjLDT8eu6Ojxtk8kiJqpgOBdFX0
         1wBSZolU/b8CNa9ERgQ0s0bV8k4RXWP2YRI9fuqQgRsw7vVmE2uhnyNFvvyBXpav1we5
         su4fTVAJGz2q8MqDNVZ6+TuM+kctknsVY9u2E7/Aa8I9z0ioWBVzl81z+OoDTRu3hE7C
         y8kg==
X-Forwarded-Encrypted: i=1; AJvYcCVGGALC1va9tOKV8BujJW4hTLdsRd1vKAXaV+eWxv3om1cyGKKVhXPAspcNnuo+PMJBUWNCOA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM5TBPTXdLXCt0u5uUJ2sQzl66W3Qm8htOdQmvhDPJiR0BTKL9
	Rc4OlYS0L0J3jDcUmjyWT9AxvImKTLxOkUo1FHZKGo7stzhANgop9F7wuJ5uNRJXRuiHRoRnntQ
	61yCOPyo3bSHa4XtDbs5h9L0YdEL9Qxu4h75nYpVb1jAIE0bungEorVqK0PU=
X-Gm-Gg: ASbGncsvUpLCIgqoRwFebtF3pJcIwQy0xgX/VeMXB3zgfS5bOUXM7kezVXCoWL9roSn
	qLiRUQkwInW1OTJS3UIuZj+sNqNE2V0dsd4al/UYNb3I1ivah9Z0bY3VJlKWnpAeqEEiA4M4R3V
	16shNy8wJfaDazGHk2t4CZH5p6jlm5wS5PzFx/+kbJ20jXs0YFVNDWVUS3PgNn6ldpide/qUDiB
	gq2ncwopWrAgWgJpsoqWuoc
X-Google-Smtp-Source: AGHT+IFQF2pH058NqXIJm35jHW/FV+ZbPWM4pad9Vni511iB/p+Jgp3wZotzA1KYXw2Im6cNyRI4hVMlqoIhjqERFC8=
X-Received: by 2002:a05:622a:428a:b0:4b3:12f7:8bb5 with SMTP id
 d75a77b69052e-4b31da3aa09mr78397721cf.49.1756728278740; Mon, 01 Sep 2025
 05:04:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <11212ddf-bf32-4b11-afee-e234cdee5938@free.fr> <4e4c9952-e445-41af-8942-e2f1c24a0586@free.fr>
 <90efee88-b9dc-4f87-86f2-6ab60701c39f@free.fr> <6c525868-3e72-4baf-8df4-a1e5982ef783@free.fr>
 <d073ac34a39c02287be6d67622229a1e@vanheusden.com> <6a5cf9cf-9984-4e1b-882f-b9b427d3c096@free.fr>
 <aKxZy7XVRhYiHu7c@stanley.mountain> <0c694353-2904-40c2-bf65-181fe4841ea0@free.fr>
 <CANn89iJ6QYYXhzuF1Z3nUP=7+u_-GhKmCbBb4yr15q-it4rrUA@mail.gmail.com>
 <4542b595-2398-4219-b643-4eda70a487f3@free.fr> <aK9AuSkhr37VnRQS@strlen.de>
 <eb979954-b43c-4e3d-8830-10ac0952e606@free.fr> <1713f383-c538-4918-bc64-13b3288cd542@free.fr>
In-Reply-To: <1713f383-c538-4918-bc64-13b3288cd542@free.fr>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 1 Sep 2025 05:04:27 -0700
X-Gm-Features: Ac12FXzOGcBqZHVXsh5dWbI3sjavR7rzJbdiLYMYiBL3jHSlObbZv5DJMOh4aMM
Message-ID: <CANn89i+Me3hgy05EK8sSCNkH1Wj5f49rv_UvgFNuFwPf4otu7w@mail.gmail.com>
Subject: Re: [ROSE] [AX25] 6.15.10 long term stable kernel oops
To: F6BVP <f6bvp@free.fr>
Cc: Paolo Abeni <pabeni@redhat.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	linux-hams@vger.kernel.org, netdev <netdev@vger.kernel.org>, 
	Dan Cross <crossd@gmail.com>, David Ranch <dranch@trinnet.net>, 
	Folkert van Heusden <folkert@vanheusden.com>, Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 30, 2025 at 4:37=E2=80=AFPM F6BVP <f6bvp@free.fr> wrote:
>
> Here is a bad commit report by git bisect and the corresponding decoded
> stack trace of kernel panic triggered when mkiss receives AX25 packet.
>
> All kernels following 6.14.11, i.e. starting with 6.15.1 until net-next
> are affected by the issue.
>
> I would be pleased to check any patch correcting the issue.
>

Thanks for the report.

At some point we will have to remove ax25, this has been quite broken
for a long time.

Please try :

diff --git a/net/ax25/ax25_in.c b/net/ax25/ax25_in.c
index 1cac25aca637..f2d66af86359 100644
--- a/net/ax25/ax25_in.c
+++ b/net/ax25/ax25_in.c
@@ -433,6 +433,10 @@ static int ax25_rcv(struct sk_buff *skb, struct
net_device *dev,
 int ax25_kiss_rcv(struct sk_buff *skb, struct net_device *dev,
                  struct packet_type *ptype, struct net_device *orig_dev)
 {
+       skb =3D skb_share_check(skb, GFP_ATOMIC);
+       if (!skb)
+               return NET_RX_DROP;
+
        skb_orphan(skb);

        if (!net_eq(dev_net(dev), &init_net)) {

