Return-Path: <netdev+bounces-81961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F6888BEDD
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 11:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA9E42E5A18
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 10:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48A0535AC;
	Tue, 26 Mar 2024 10:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="v6e+0QPh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0151AEAF6
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 10:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711447702; cv=none; b=Tqof/oPX5Jppw+gm0eI+ZTfkB33Rz2qZLxJuGQILhdv6FYpzTcEupPuZKQsPy/buVL+dbupsp1ah7WiliOteiBKWWXyZ/VTpECwHJf+shawckbmUfgAQVJrDfnStZUPcWElUfv+Ww6gguYiBbZ8fYjxZuXcLdDJ27b1Dwb0QUV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711447702; c=relaxed/simple;
	bh=iMasg3RXiM2zMrPtA/PUIeA9zhqUb3/K3j9D+/sk2KY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lRy/4JVd0sZ3ZBL+Q59frZdxUKPtU2t/kQ6kpgxj03LOvwvtZwVN0CeXxS4tRgLG51lufcB5XsCMjmEc37aVM+Om+D7iB34hfwMnL6g7P3zPuOCMMZZC/WIvmiNyXtvUgXrFMmAJhs3+ARw87h9poM03ivVALVcXEcNyM7lM3so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=v6e+0QPh; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1C1DC3F204
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 10:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1711447698;
	bh=i31uu0Ui9r+LT8kJmavX0tuIXLiQjHwXp0dNp5AvTr8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type;
	b=v6e+0QPhrLTLYLwWXXSRWBs8kzc2h7ZbiWTTerVRFeJrR4T7FyS/+Bb859oHYKY67
	 f6jB9D7EDJfYT6s8XTM6Y8TL8k/9eMqrEpqippSTckOxlZf2vgqigY92s8p/dpHQ5h
	 5Az7odu8uRF+xU1FUf9drlXau/0RSyQlOph9hJ1caCmZ3Vl/d5U7yfz4EsdThtfPEd
	 loLKmbhk/QN+zQuIc6ufM9dEnQFkpd5nLRNVx52sysPBPcA2NTKjzzkBsIt/shZEGO
	 etqlQJYKT2l4Qgj6WNpy41LNg6u8F1oIK/xhg1d1NxFwqh+b5QwIJYDKCgv6Ogj/nH
	 /tCO49o1bvJtA==
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1defc12ef3fso35517545ad.0
        for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 03:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711447697; x=1712052497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i31uu0Ui9r+LT8kJmavX0tuIXLiQjHwXp0dNp5AvTr8=;
        b=qx+k/xcW4TKRCx6Yx5RdVr4TnCSl9/8gwgNHPXQrEW2olIyTQzm9qagk4sMpTnxJt0
         LsjQvp1ApVifm4wUmJrGRrKNEy4q0AwyuLBCDXdQmCBT8uwBznGWUcoGtrkhvdG5/Zd4
         hlThEJCdeWIJ+wf4TT2wohj8C2U55K+O9su3dQPEA2pW9QFPaXQpplbv4wcReuizYXBM
         XBeaWxdAcwb4rY5d/pxUoRKBBUeEze5N39Fq5W9w9R30KnlQdlMR1vBnkOOSr4xU9DMs
         dDhQCKJrsK/WvqD6d7VSScIaKi2Mbvp3NhvlD3yrEe6kaIQxfDOnKv+X3J2qiuNKWRkK
         kv/w==
X-Forwarded-Encrypted: i=1; AJvYcCUeH6PlhVLzlq8+VEe277hvoznkc+MzlqNJttD0Y+6AkkHoPOhPhkbJiniarWRHMpSUCMFM0oEPMGaIqWy136Kk5UIOYEYm
X-Gm-Message-State: AOJu0Yx1Io6vCgWTSjI7wxqSbpwJdj9nfdeeC2EJENjyVng4+wW1ySQF
	JPg6r/rViaFEqaxF3QNFrEkRQfFjHtlB2DAxJaHVXZhAtAKgmgC4xHjR+87Aomji1QvA8uv9GmF
	qcQteNwwiz+TqeG/fKuyz+m3NOdjLs5G1NH/TDwU88mGnEFv0qPdVxh5yXc8qwNvrXazKOA==
X-Received: by 2002:a17:902:70c8:b0:1dd:df89:5c2 with SMTP id l8-20020a17090270c800b001dddf8905c2mr1142256plt.22.1711447696762;
        Tue, 26 Mar 2024 03:08:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvn/WKom1ejskT1JAUaGxB10DGNNfX+RLkfo78oEtGyJQWcriTiXiqcCkkAeRDzDOTb7wbkw==
X-Received: by 2002:a17:902:70c8:b0:1dd:df89:5c2 with SMTP id l8-20020a17090270c800b001dddf8905c2mr1142241plt.22.1711447696451;
        Tue, 26 Mar 2024 03:08:16 -0700 (PDT)
Received: from localhost ([2001:67c:1560:8007::aac:c02c])
        by smtp.gmail.com with UTF8SMTPSA id i10-20020a170902c94a00b001e0c949124fsm2752115pla.309.2024.03.26.03.08.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 03:08:16 -0700 (PDT)
From: Atlas Yu <atlas.yu@canonical.com>
To: pabeni@redhat.com
Cc: atlas.yu@canonical.com,
	davem@davemloft.net,
	edumazet@google.com,
	hau@realtek.com,
	hkallweit1@gmail.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	nic_swsd@realtek.com
Subject: DRY rules - extract into rtl_cond_loop_wait_high()
Date: Tue, 26 Mar 2024 18:08:02 +0800
Message-Id: <20240326100802.51343-1-atlas.yu@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <bdfd3a4938e2eb37272a9550c869bb557fb70cab.camel@redhat.com>
References: <bdfd3a4938e2eb37272a9550c869bb557fb70cab.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, Mar 26, 2024 at 5:09 PM Paolo Abeni <pabeni@redhat.com> wrote:

> >  drivers/net/ethernet/realtek/r8169_main.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> > index 5c879a5c86d7..a39520a3f41d 100644
> > --- a/drivers/net/ethernet/realtek/r8169_main.c
> > +++ b/drivers/net/ethernet/realtek/r8169_main.c
> > @@ -1317,6 +1317,8 @@ static void rtl8168ep_stop_cmac(struct rtl8169_private *tp)
> >  static void rtl8168dp_driver_start(struct rtl8169_private *tp)
> >  {
> >  	r8168dp_oob_notify(tp, OOB_CMD_DRIVER_START);
> > +	if (!tp->dash_enabled)
> > +		return;
> >  	rtl_loop_wait_high(tp, &rtl_dp_ocp_read_cond, 10000, 10);
> 
> You are replicating this chunk several times. It would probably be
> better to create a new helper - say rtl_cond_loop_wait_high() or
> something similar - and use it where needed.

Sure, will do, thanks for the suggestion.

