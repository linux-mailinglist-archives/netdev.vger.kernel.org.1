Return-Path: <netdev+bounces-141912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CAC9BCA2B
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 11:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D310B2112C
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 10:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A313D1CF7C9;
	Tue,  5 Nov 2024 10:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RkBZDC4q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACD61CC881
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 10:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730801943; cv=none; b=AoBOkBevy66RwX0NYTL1Alu90DBRjHGK7AaNEj7R798S/i/O1fp0MisHf0ls1vYeOx8gLOoP+v/2ybh4rNAHVrLRgQuu/9E6QTCI0gA60skLY+PMfjaO/0IFS0/OripbmIcb+fK+db7MuIgzNLjjCCDNzaaOBcCceqQ3d6Mw1Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730801943; c=relaxed/simple;
	bh=7bAQRPv5AWFcK044DEMTSFsVD3HsIKFysrUuV9ZwaFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c58jlu7ZRb5OlR0iGDY7YzcMjdZfDh/2OBTrfjW7l4Kl57dutak0q3V1Q+UTv54SZaf6QCYz8jRLvowNB1zIt4ordpcqlNaCSSfHSFCgDQzLoYpPD7W/HC9VgcReOZ5Yo9uO4TWpeeU4D76cc53wFmuBMPduMGbSfP/vX0CPNzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RkBZDC4q; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5ceb03aadb1so5656928a12.0
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 02:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730801940; x=1731406740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7bAQRPv5AWFcK044DEMTSFsVD3HsIKFysrUuV9ZwaFI=;
        b=RkBZDC4q+EIFBd/dHVONpDqA7IL0CoD3T+21fn7Iceq9RDzPPPJY5oABOlZdqA8lYZ
         JrRM1008NSHLpY3k2wG7n7fnSaPBFPt0EMiw1HnbPM5ut9bOjkojpQF6Ft6bd61epQ82
         S6MSwfjhnqLA6tqU3xy5fnb3QcW0pmoJN5SzOOGYwLGcCyNVZyVfBtTh2dXBQowvPQRt
         NgRC0BBCHnuFtPOSXab13ltN3exBWkKUU4L4fqJI7NfbhH8F9lC0QIWwJdyd3+LQkLeP
         S5Qhp5O39G9e9nDcvMBnRAhHxiq6A1Y3QltbIr1V5fuPGjUeU2FhYnQaW47DssOxYqYf
         YVJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730801940; x=1731406740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7bAQRPv5AWFcK044DEMTSFsVD3HsIKFysrUuV9ZwaFI=;
        b=OVRMe7iCwG/ew4bv0PlJVetoZJBGfZGNfyz5K4AWLf1U0n5Kc/DxHgJsRCGOgIcUVE
         3HTU3HRsCrxi2V+VIVQ+WEYrD4e7vC67SDPUplFM/llIuljkMPgcxsf0ay+64OB2/y2i
         23bCuGcYVGpdfMn3g3j4NN2whikszhtnua2gGwB64nEm16Tmkj7ST1ADdvPmyaFrgbe5
         BHA2hmnFF8oeHxmDKekG7o+6ed3nhfXqq7/dJ/Nb/tAjLYS+at/t+Y1ecmfUkp7mMbWB
         07UqQojp5YgWoO512WUCsTxrEeLeuvtMdW9ubBI3dHh1IXuX+lacb/VkHF9ZRGpn1C2R
         oGQw==
X-Forwarded-Encrypted: i=1; AJvYcCWSux9zsc26JGTbGk+xoTFBa9wYjMfcuS3xVvAoNcgPLdO3Pz+TtLD+DWsFtvptzB58rEhJXWo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0IRRibT6Vaph8IPJypJCraHBO9njEy9wmoCT2Hlsa4tGEQBk6
	akGSnC2lk/+HLZewVvHqEMEqDyhnOiLGmqFWSTbfk31PIXfE7lMrkH8nYVDNf7oF+YlMJZfDLh2
	CWkT5XPdGSjq1fxp1cGPKkJUT+BQY8LXKqWFa
X-Google-Smtp-Source: AGHT+IETs/uXUXCPOTeqLs+Xu8KfURlVE53kGyOl1zoYFEvbboXiWPhtd6yr12XW54bYXfxek2EV0uuHiqCx385TQfI=
X-Received: by 2002:a05:6402:84f:b0:5ce:d43c:70a8 with SMTP id
 4fb4d7f45d1cf-5ced43c71a5mr5336014a12.25.1730801940133; Tue, 05 Nov 2024
 02:19:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105020514.41963-1-kuniyu@amazon.com> <20241105020514.41963-3-kuniyu@amazon.com>
In-Reply-To: <20241105020514.41963-3-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 5 Nov 2024 11:18:48 +0100
Message-ID: <CANn89iJX8fQXCqRcuaTw1VN+dOh5oURtYBW=Ag3=GpeLBPFWXw@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 2/8] rtnetlink: Factorise rtnl_link_get_net_tb().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Daniel Borkmann <daniel@iogearbox.net>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 3:06=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> In ops->newlink(), veth, vxcan, and netkit call rtnl_link_get_net() with
> a net pointer, which is the first argument of ->newlink().
>
> rtnl_link_get_net() could return another netns based on IFLA_NET_NS_PID
> and IFLA_NET_NS_FD in the peer device's attributes.
>
> We want to get it and fill rtnl_nets->nets[] in advance.
>
> Let's factorise the peer netns part from rtnl_link_get_net().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

