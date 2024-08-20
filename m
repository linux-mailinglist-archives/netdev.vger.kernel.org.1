Return-Path: <netdev+bounces-120072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5275E95834D
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 11:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 855691C242F2
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 09:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1006418B473;
	Tue, 20 Aug 2024 09:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NrCaPcGv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6279B18E373;
	Tue, 20 Aug 2024 09:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724147740; cv=none; b=Hl3pK2EuhqhoIfUG28BEdYHcibbb7qpLrarB/19CS9j6golOf//RyBkhNAn3E020QqXqzViZfPr1YYB9SDtR3j3jJMBMWKpNPsIvK48xBrAbDqJsW2/jIUoyq8q5rcAr4kPdYqlNQ+iQoo5Fn9OUIWP8NldiPnJsTTB8qscqImo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724147740; c=relaxed/simple;
	bh=kFr2YJvhs+zTyd7WllTTne0tbaKD/f5AEoSc3dDD4h8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6gB+eOLvILPk9jGAfg5hGucTXmKgzaGOTXnEJMB+L3CqOaoVv58x+1YxkN7Xv+RST2ie0zkv4yq/Zza1EyRQzhY2vOXBx7RPTD190FCeeKzJ7/MT+BGCiXvojLKFUoy6KwnnPJBAielH44gxEmoJItbLx0ys5Kyn/oUjfxgdog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NrCaPcGv; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5bf006f37daso1871615a12.1;
        Tue, 20 Aug 2024 02:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724147737; x=1724752537; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uUSpPNWLulDMOHLV3kIAUbCGHrOEWNyLTeWcImUN1ec=;
        b=NrCaPcGvGP+NlQ7wCiX0HtVeiWY2angyjKlpnEvpNuOT0Q6qLtrqBdIm+RAB6njD5R
         udrx7SPy2MBC6M5wUM2aLHQMsT1+NeZblTB2J707G7KTasVMIo+E2zRUVOxsPbBRo/Ok
         7Bc2Bi9HL5isgq4khtKwugqoGd217W0W8UWM0I7L6fSJtrogXDhUm5LgqXDFxXbtlOT+
         OWUSpMvL1sJFZQxZhOl80W0cu6LOcjwu6ImJWP3Fm7X/y54VhSK+Nr4gefGl2I7n9TJG
         XIrzgYnaJK2aX5QDlus5IB2QkJQxbp57huru8ulvROZ+HVsKQIXXjhMHz4BEtpdh2N1S
         dSTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724147737; x=1724752537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uUSpPNWLulDMOHLV3kIAUbCGHrOEWNyLTeWcImUN1ec=;
        b=UmXFJ2xNkhvJSnLmX+scokUwOJNsSd1aALEVz2BrNW61qiUv2lj6AtFLwyS4d5PEiq
         ZwmamIFwuK60Jm2WjHBHcg1HUxYTHP9BP9mjdJxSDEgTXpXkD9zhAjsNvskgJmGz4Wuy
         nqplqdKTyzVuaIqGmToLmHAhDAyaX5ts9gmuS/g8UAL/U6d3prCK9F4yZiSQiaTo8g9k
         QDTA4r6Ju2q/57gnAuAf4EWkIL/NrWJ4j7MKXsshUSshmKdQGdYpwCP9XeEMAtFFeFTS
         KVYI6MI3AhBMc5v2ZGBPYRggPKJrULt+sFVq2GRsRdU5J4qG5SWVw/EtPet1otsrHoyu
         48Xw==
X-Forwarded-Encrypted: i=1; AJvYcCX14+CZJqAtVZAn4B0awE7HKKKW2OqlZ4R1Nj+ZewdEM75WP6Dm/obihdISMXi2llQ4eXdgPDSC@vger.kernel.org, AJvYcCXzR226tQq6WJsYWjY+v44iIOqZfzVOR2T/o3L3cqRpKCauIHJcbKMegiDKPhyobj2KylW8v8iUTXnUgkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9nxAByAjrIlzYw+Bduz0nX6TXOLb8CyEUe08DxUDS6XJDM25z
	jYGV1EOglnTMSvz8LTxGaP5Clb81o+fW2ihFNWL7Qisak1YB/uhU
X-Google-Smtp-Source: AGHT+IH5LTsYnL6x/hh2mXdZe+5zXyKYpPulCp9WMq2HFgFskdkQAa8jNKnhkWrXxaKseumfJVV8YQ==
X-Received: by 2002:a05:6402:2802:b0:5be:fa76:55b4 with SMTP id 4fb4d7f45d1cf-5bf0ad6fbebmr2490826a12.16.1724147736212;
        Tue, 20 Aug 2024 02:55:36 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbe7f3e0sm6561853a12.71.2024.08.20.02.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 02:55:35 -0700 (PDT)
Date: Tue, 20 Aug 2024 12:55:32 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: Serge Semin <fancer.lancer@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	xfr@outlook.com
Subject: Re: [PATCH net-next v4 1/7] net: stmmac: move stmmac_fpe_cfg to
 stmmac_priv data
Message-ID: <20240820095532.tlwbogzhvpmejnvw@skbuf>
References: <cover.1724145786.git.0x1207@gmail.com>
 <cover.1724145786.git.0x1207@gmail.com>
 <2fc5d2d43b583f3e66b843783f067f5420a0c8da.1724145786.git.0x1207@gmail.com>
 <2fc5d2d43b583f3e66b843783f067f5420a0c8da.1724145786.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fc5d2d43b583f3e66b843783f067f5420a0c8da.1724145786.git.0x1207@gmail.com>
 <2fc5d2d43b583f3e66b843783f067f5420a0c8da.1724145786.git.0x1207@gmail.com>

On Tue, Aug 20, 2024 at 05:38:29PM +0800, Furong Xu wrote:
> By moving the fpe_cfg field to the stmmac_priv data, stmmac_fpe_cfg
> becomes platform-data eventually, instead of a run-time config.
> 
> Suggested-by: Serge Semin <fancer.lancer@gmail.com>
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

