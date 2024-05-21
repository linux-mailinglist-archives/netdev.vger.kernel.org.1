Return-Path: <netdev+bounces-97278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D5F8CA712
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 05:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF07CB22887
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 03:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F41018E1C;
	Tue, 21 May 2024 03:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="dVZY/b1w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA768210E4
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 03:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716262319; cv=none; b=qiZ55XkKmZVJZFOayt3FyG3GbCzOATBthz9jqfCYqjW1LJAnYesx/V0Bku/ea4Aeyr1LuEJQI9BQCsXbUWRxtTzbPg7Y6h6aCUDF+660s9aplFxjBe1qR6R2xy6eiyhrcvpU3/xnt1cgRbwspzC1L/AnoObiRbS2gFDmVbb1Lj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716262319; c=relaxed/simple;
	bh=MFCU+pjB3KCKhjmKoPu7wpzHpc58NnIFXFSypYZ2ds4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EmBRCzqsOokY2gPP8HP23v62BvLg2nXsOvIfoJvfvswC1ygjTW+ARD1XlsWE8eFHqgdR9psUoOrTLFdSOiW2DXQaBRXdxulVET8fvGTTS/eVq2GR5shuniJOotc+8qpF0lJ48WO/wUE+q47HLJNRrzEUDE5pJ6uxqh5MulEpqKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=dVZY/b1w; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 90777411E9
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 03:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1716262313;
	bh=oRT4EC1vFVwwe/RwAMWjDpt+UAEk61rLUizH+FeKckE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=dVZY/b1wgbSp1oD1d6pAxFCX6N/oFTO9SFqa74hRmKu0YIaPS/0DgHKQ83RDXpCnn
	 LxlmB00qb7Qzmr1nvPoaMCgKUPNLHP9zYV8dhWHgTISsH2bXkWJmlP2jryKldkJF+k
	 Wppy1wf2c4TpUBpCi3tlwftGzosyplpaJTGMHCbxoRpKVAo6h/+Hv0t63/F0Y+JsT6
	 G9XnhFMc5xU+Rve7C525juoO56tDZ95TvgUk6Fjlz0lvpPyKgpfb/nAZo0pdcurEWX
	 cmwcK9UKcfUPpdjrNyecsWZr/IRd3222VtesOVtfPWsGx3PTsyQVkyQ5glvqJCXVEE
	 PFHo8l0ExVAAQ==
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a59c3cf5f83so696688966b.2
        for <netdev@vger.kernel.org>; Mon, 20 May 2024 20:31:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716262313; x=1716867113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oRT4EC1vFVwwe/RwAMWjDpt+UAEk61rLUizH+FeKckE=;
        b=pH9fwL9GuoWC2v4/JBkqPMcgbHvOx9Hg8IASjOKBat05wCL9mLFFAWNute6e8sDC3f
         lxf5Y28JOkYU83E1NR6Rk0NI4hlRo/uZNyMEWghJrxJMeY0rlyS9CRVxvzpQ6akMgwQK
         VRgiatza/fdMPohHIXD95nLR2IfaQUTZtXox9Hl1fV8/5Mipgh58p6oH5soeCRiHWpKe
         uEC7uzP8YyzVi3/aPocmUir+8i5FZH/htHkvl4uMA6MDbYqQjawU5aA05BP+hpT5mn1v
         NOJ/ZZN7NqJ+dHF4aK8TMC74b8EL6qvq2X+oWSCWtcl9uJhAB1yUjYEb079iyu91fa5i
         kXKg==
X-Forwarded-Encrypted: i=1; AJvYcCU8BQ0PO9GPBbU2zvh7q1UdbAAbXPXGu6JbiJqbiGP7lBkhbhXhe7UwhE/BkEkKEVX185pa+EpgS7vLvNmE+Sh7Ltd+HEM9
X-Gm-Message-State: AOJu0YwVyG6cUs1V2abKdbUB1feVj8Wcmh8quq1D+qj9YlGSUDqaugTZ
	S5scSmHIeRy6Vi0uck8AhIMPB77EG7g0zYJjgGMwzSHxb5NQmOl6CLiztOu3yIBH0K8suH5PHEo
	4mjv5HfI8SFzj3VqSzh5hhTfRDVFlVzVUn7AZj5kM9oO66z9mzggGNMUp8faQNI7SYedVEAKky+
	ErxAUYxd0awL/D7OxKEpqkxcmVqWFYxpiuSNDH0H1+JcGx
X-Received: by 2002:a17:906:c452:b0:a59:ee81:fd68 with SMTP id a640c23a62f3a-a5a2d68089bmr1950750266b.71.1716262313284;
        Mon, 20 May 2024 20:31:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOJPK5+qn5c923mZ3slXAnGra7/NlJptA4G/g7FgwPIMj5jx6DIRqcDO0o17J+ODRWW86LPcncRhI9GyxkwF0=
X-Received: by 2002:a17:906:c452:b0:a59:ee81:fd68 with SMTP id
 a640c23a62f3a-a5a2d68089bmr1950749466b.71.1716262312944; Mon, 20 May 2024
 20:31:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520070348.26725-1-chengen.du@canonical.com> <664b97e8abe7a_12b4762946f@willemb.c.googlers.com.notmuch>
In-Reply-To: <664b97e8abe7a_12b4762946f@willemb.c.googlers.com.notmuch>
From: Chengen Du <chengen.du@canonical.com>
Date: Tue, 21 May 2024 11:31:42 +0800
Message-ID: <CAPza5qcGyfcUYOoznci4e=1eaScVTgkzAhXfKSG3bTzC=aOwew@mail.gmail.com>
Subject: Re: [PATCH] af_packet: Handle outgoing VLAN packets without hardware offloading
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Willem,

Thank you for your response.

I would appreciate any suggestions you could offer, as I am not as
familiar with this area as you are.

I encountered an issue while capturing packets using tcpdump, which
leverages the libpcap library for sniffing functionalities.
Specifically, when I use "tcpdump -i any" to capture packets and
hardware VLAN offloading is unavailable, some bogus packets appear.
In this scenario, Linux uses cooked-mode capture (SLL) for the "any"
device, reading from a PF_PACKET/SOCK_DGRAM socket instead of the
usual PF_PACKET/SOCK_RAW socket.

Using SOCK_DGRAM instead of SOCK_RAW means that the Linux socket code
does not supply the packet's link-layer header.
Based on the code in af_packet.c, SOCK_DGRAM strips L2 headers from
the original packets and provides SLL for some L2 information.
From the receiver's perspective, the VLAN information can only be
parsed from SLL, which causes issues if the kernel stores VLAN
information in the payload.

As you mentioned, this modification affects existing PF_PACKET receivers.
For example, libpcap needs to change how it parses VLAN packets with
the PF_PACKET/SOCK_RAW socket.
The lack of VLAN information in SLL may prevent the receiver from
properly decoding the L3 frame in cooked mode.

I am new to this area and would appreciate it if you could kindly
correct any misunderstandings I might have about the mechanism.
I would also be grateful for any insights you could share on this issue.
Additionally, I am passionate about contributing to resolving this
issue and am willing to work on patches based on your suggestions.

Thank you for your time and assistance.

Best regards,
Chengen Du

On Tue, May 21, 2024 at 2:35=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Chengen Du wrote:
> > In the outbound packet path, if hardware VLAN offloading is unavailable=
,
> > the VLAN tag is inserted into the payload but then cleared from the
> > metadata. Consequently, this could lead to a false negative result when
> > checking for the presence of a VLAN tag using skb_vlan_tag_present(),
> > causing the packet sniffing outcome to lack VLAN tag information. As a
> > result, the packet capturing tool may be unable to parse packets as
> > expected.
> >
> > Signed-off-by: Chengen Du <chengen.du@canonical.com>
>
> This is changing established behavior, which itself may confuse
> existing PF_PACKET receivers.
>
> The contract is that the VLAN tag can be observed in the payload or
> as tp_vlan_* fields if it is offloaded.
>
> > @@ -2457,7 +2464,8 @@ static int tpacket_rcv(struct sk_buff *skb, struc=
t net_device *dev,
> >       sll->sll_halen =3D dev_parse_header(skb, sll->sll_addr);
> >       sll->sll_family =3D AF_PACKET;
> >       sll->sll_hatype =3D dev->type;
> > -     sll->sll_protocol =3D skb->protocol;
> > +     sll->sll_protocol =3D eth_type_vlan(skb->protocol) ?
> > +             vlan_eth_hdr(skb)->h_vlan_encapsulated_proto : skb->proto=
col;
>
> This is a particularly subtle change of behavior.
>
> >               if (skb_vlan_tag_present(skb)) {
> >                       aux.tp_vlan_tci =3D skb_vlan_tag_get(skb);
> >                       aux.tp_vlan_tpid =3D ntohs(skb->vlan_proto);
> > -                     aux.tp_status |=3D TP_STATUS_VLAN_VALID | TP_STAT=
US_VLAN_TPID_VALID;
> > +             } else if (eth_type_vlan(skb->protocol)) {
> > +                     aux.tp_vlan_tci =3D ntohs(vlan_eth_hdr(skb)->h_vl=
an_TCI);
> > +                     aux.tp_vlan_tpid =3D ntohs(skb->protocol);
> >               } else {
> >                       aux.tp_vlan_tci =3D 0;
> >                       aux.tp_vlan_tpid =3D 0;
> >               }
> > +             if (aux.tp_vlan_tci || aux.tp_vlan_tpid)
> > +                     aux.tp_status |=3D TP_STATUS_VLAN_VALID | TP_STAT=
US_VLAN_TPID_VALID;
> >               put_cmsg(msg, SOL_PACKET, PACKET_AUXDATA, sizeof(aux), &a=
ux);
>
> vlan_tci 0 is valid identifier. That's the reason explicit field
> TP_STATUS_VLAN_VALID was added.
>

