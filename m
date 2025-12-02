Return-Path: <netdev+bounces-243117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C14C0C99A90
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 01:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 69D5B345774
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 00:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5DF1B424F;
	Tue,  2 Dec 2025 00:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="1X8FCg47"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE51A1B3925
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 00:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764635901; cv=none; b=BpSO2CyPU9EWuXd6xU7DObsxD8H3JZjdGmuh2U8V7wpTgZlbPZb6OqG893kQZcMnrG0pN0AljGrh4whDi6jyIUmNmpICW8s7seidmZeAK32UlEBxwiIaPsHjvikxZiv5wCgfrXlL/fuuNrT8+mZDjhyKzM6+eRBRBibC5SkDg4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764635901; c=relaxed/simple;
	bh=BujrSu+y9SwZZzARvq3aZf5jeZIETdmmjG+R0lJrl3I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OdT4Cw6r1SylwtRtCXVaQr3QLFOA7aEp4a+Rxa1iuAuptNJ+hERuBlRZpVBIcSLkqPGdNDo/S+OXLKmqx499OnPqPfiRvsrafcXVDiGuHrEdBYhWHPwZ6bSezDnDqrBQluC1MDMSNoc9AoRVuU/ofpazFlWjh2aAGsF7s5VWr8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=1X8FCg47; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477a219db05so31047215e9.2
        for <netdev@vger.kernel.org>; Mon, 01 Dec 2025 16:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764635898; x=1765240698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QHgdrCMSyZrsbol2Ny58yvtqwGpR5hU0tMP2n9Q11Sg=;
        b=1X8FCg47Qvxdn19DMsVMmYfFFDPdnXzjvRvTskXrqDPBB29uPfF50sF/ybOTBhoN+j
         fuHH2IIpFkX2+VMXlw55QNWhaL07K3oLEedJ1MHqBzwvr1pNy3niPBgWi0PnQ7e4uyrF
         BSXwBYEZQC4UQnqIjOFfgZFPXGaFGJpqRq6+TB0YnARqTdbo/NcK/zKlDXGPGY/qO16Z
         bsDRAtjEl+M1wOu14RAh4vHvyvT6ovY0oMmU2xYhjm3PBJio66az+AcjweAIRdlCsdeE
         tb9ClMn18zkbHZqfrtk0Lxq6y4iAe7C9hqKYqTzyAaJzrvGFvKdDalofnWozOF5YzEdE
         SGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764635898; x=1765240698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QHgdrCMSyZrsbol2Ny58yvtqwGpR5hU0tMP2n9Q11Sg=;
        b=maO05YJUvtewG+JW0Z3xxzBfTbU0kOLIURmYl4TvnvFhIfbBo/dsle2ktZCoGRYuBv
         kKhGTbwQ6tSd4koAq9OfD7hJcXQcy0wgdBDLHYvYRZZUCsr9ttVHHuUb4xJUQJfRNSkX
         5pXHx82RYylM3v1CDpwFNXTL1I8hPA/92FWfiVX2vB4mOBlHPCuvO6zwuFewyTUix7GH
         XZfFfCHa5uyQQp0OMYgql2U9A45erhE1fYiSt6mCyv1T2iVzleYeRyfue3If9dhOGg0+
         Ql2ulNkS/ip+sHZdB2q58tZm0oeyUoP7DC/bhcLnl2d+DQmf/1FRANDt6Cit4No3s4P4
         aXNQ==
X-Gm-Message-State: AOJu0YwJ0SRl/wyER25rklNvKUdDEP95ImSfgp2YEpciDwmAlxoHAQRM
	AuooCfqBW9IyUpu4TDWH3bxB935defHIX12BLYNXBYx3p75TstvStzb4TIG0dlaP9D8=
X-Gm-Gg: ASbGnctq0GYNTjAaBHu03eoV7pnXnINfHCZGdNecy821iMOaS0THPZJonHe0p9lXLVM
	RJ33mjJgQHPRV/vtE8JcKCVrlGpXKeHgD0VVMTG5Hy0TmTj3ftqcAGbnBMRQwMbbg0jpkK5NklF
	TDOVGV3RaQH6PwCndbt0qmkokC47QVyhpg6m1cEX8sOeA4HKzgKFPsFYaMIZ3+GFDXIOP5Xt+Fk
	SOSg6VwBIXwRbd4+JxR+//3/VrTZA3ger0Z4rx1N6l/sa3Ejuonerkv3Ocxda6/J1Gvzwkk4Zxj
	4gHzk/7LW98TeODvi3WAT6OBV/l4W0aDfrMqeZDBlcE6OdXivkg8eENJTOee0ueDhEDGh15LtDF
	VvcLuQOfLyWBE4cldyaqvmdL5RubyNiHzmsmljngN0b/d6Bvvwv3iOermILQObaZjuTmuLdWZbT
	eLx63g2adyriaNNLEGyns/G+MiOo88RMDuPz5fBdANsEcyox0yAu5nMBDjgLu/B10=
X-Google-Smtp-Source: AGHT+IEmxd7MorKQrK7TTaf6Wk64mPP08pnZ/XYkB8I8vFTvRhnlneHMm/ytcv8HZc+8AtFDfsjPCQ==
X-Received: by 2002:a05:600c:1caa:b0:477:8b77:155f with SMTP id 5b1f17b1804b1-477c10d4935mr469757915e9.8.1764635897998;
        Mon, 01 Dec 2025 16:38:17 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47905302ef1sm164565595e9.16.2025.12.01.16.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 16:38:17 -0800 (PST)
Date: Mon, 1 Dec 2025 16:38:10 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: netdev@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, Oliver
 Hartkopp <socketcan@hartkopp.net>, David Ahern <dsahern@kernel.org>,
 Rakuram Eswaran <rakuram.e96@gmail.com>, =?UTF-8?B?U3TDqXBoYW5l?= Grosjean
 <stephane.grosjean@free.fr>, linux-kernel@vger.kernel.org,
 linux-can@vger.kernel.org
Subject: Re: [PATCH iproute2-next v2 5/7] iplink_can: add initial CAN XL
 interface
Message-ID: <20251201163810.3246dc49@phoenix.local>
In-Reply-To: <20251201-canxl-netlink-v2-5-dadfac811872@kernel.org>
References: <20251201-canxl-netlink-v2-0-dadfac811872@kernel.org>
	<20251201-canxl-netlink-v2-5-dadfac811872@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 01 Dec 2025 23:55:13 +0100
Vincent Mailhol <mailhol@kernel.org> wrote:

>  
> -static void can_print_tdc_opt(struct rtattr *tdc_attr)
> +static void can_print_tdc_opt(struct rtattr *tdc_attr, bool is_xl)
>  {
>  	struct rtattr *tb[IFLA_CAN_TDC_MAX + 1];
>  
>  	parse_rtattr_nested(tb, IFLA_CAN_TDC_MAX, tdc_attr);
>  	if (tb[IFLA_CAN_TDC_TDCV] || tb[IFLA_CAN_TDC_TDCO] ||
>  	    tb[IFLA_CAN_TDC_TDCF]) {
> -		open_json_object("tdc");
> +		const char *tdc = is_xl ? "xtdc" : "tdc";
> +
> +		open_json_object(tdc);
>  		can_print_nl_indent();
>  		if (tb[IFLA_CAN_TDC_TDCV]) {
> +			const char *tdcv_fmt = is_xl ? " xtdcv %u" : " tdcv %u";

Having a format string as variable can break (future) format checking and some compiler flags.

