Return-Path: <netdev+bounces-155507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE58A028EB
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 16:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 994553A4F72
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 15:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C7C15666B;
	Mon,  6 Jan 2025 15:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UnS9Avxv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C52C1598EE
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 15:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736176591; cv=none; b=J1u8vvRxvqLTeHJsPt2mkWH+H6q/kDt3lTUxM4z/R9QHElbB1z60Jowl5jj2YOmwtDc0u7qzlp85QIjxyGl9pktX4TyJlAYbr8/EcaaCkX9EULsHiKaJaRNdDeVi3Q3bwIz+OXpMjeTJvlAceI14dV5ymIpAymFBZM0TMqHH+90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736176591; c=relaxed/simple;
	bh=rodgNE7S5Eou5Dmf7DDkUVN+T8qJZfiSHejuZbq5rGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDVeEgJLU9cDfewptrALnYNG+IhwM24cX50T21/pI3FKhMhW8j+rfMmFW7z+GkSEsO6IDvP9a4OBnEYamc+swxzpo9U3sE+fVYwKVJtN+KPEH4x8xa1xoEngVZ24VZVFL5NGj9Zwrll3WRvkwzEpekvuhO1O4P8c5zX49iZZgPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UnS9Avxv; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-216401de828so196979475ad.3
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 07:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736176582; x=1736781382; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tUADEWcSIoXeFDBzmkzcLA0fNRngpyygghL62TPDyUs=;
        b=UnS9AvxvkaBZzWbBIdyIi3+vXMkimt75ilxbi7HLPpXypYEmIMYq1n/BzUOQnQh5kO
         8xnR9T64PKpAECVx5fnpFmQIwnUZ61IbuuksaPPgL56zYaqLRV91XooPPfzJ1Cjpb3Kf
         3Ra1u1ALfZKUR6XRBaqFMwxqxW5vw20RLvavw2NEkoN262EDPdEexvuIUWz/2VW3Jrbe
         bxjUfiPD/p4i83pjnjiCstMQGbJyUrVfh8xkZf6adalnu48ceyUMG3ddmn3PIXprcsBb
         RcJ6xCUTtAgIT1rrMXonkceQ5tYh9+iuuyQO7+43QFWJChlwnJdpLNDAcTwu6veQtaPN
         4+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736176582; x=1736781382;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tUADEWcSIoXeFDBzmkzcLA0fNRngpyygghL62TPDyUs=;
        b=QC+8ECBfRAKQlY0xrLN8qSLyJ4CRWyGE2XH0Xa9iZQ7qR1AeuDG2toUKdBvRvWAQgS
         krioCmIWDpgF/5020JcspyHODPoj2sQGp860O/0MO3wBJhtwvEO5kIsL8AQcciRwvEsz
         NcBBquDjH4iXfANByg72yB7qeHi7B+I0rwPzaeEh4ZcU3KcxEUuWrEbJuKSwh/gfmjVd
         DAs5wxAGx7QDuVU5r4ZRQi8Ja4M9JKmFk14upd9cuT2dQIXlhvb7dmz3dZweEgf60p/X
         1NchiLvJaBZtDeFnBlGJIINrAj9poWDz3lYeVRkxEB6KsqjgH1lR+BH4gPIX6iC2sYDA
         gUKg==
X-Forwarded-Encrypted: i=1; AJvYcCU2Nj+R38Ocs33WFxcpcWIZgMWy42TmsJd7xGDhkqNLAl4Eh02I7zwxVRTBTtQs/K2hNfAW4Wc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoNfftIMnjrPPMjNE2z2VhFIzFxzHslukrf2mt7lmUwOSvlsS9
	LteSxLjVX5IGDADRgUFsmx0/2Bw2bYIn7N9Tg2C/yQtZLNFz1WOb
X-Gm-Gg: ASbGncsfKV0aq0hjX0ps0BED3bHssjEOaOheeETW/ThbOm6qX8VIaa1dWiJbUvYTPGR
	BjNe/0is+u4YHFDZqRuLvMyRhXt1pCpBhAfpBb95c1p1DIcG7R+a6HnHrOIouA50qfSZSHI3R8M
	6DjFtWpZw+uq0zjFjEeIpJPxPiShqFe7XWAN7czNnGAtOoYQEWZx7vOongTN/iTC0yJQ6pdwKBA
	aabfO7wE3rWfXHFoKv8LJQK/9wzqVgS23+n/1RT9d3IuLU9IRVU67ESPFMu5RTyQvK4/Z48grZF
X-Google-Smtp-Source: AGHT+IGvx3NDA/vnvLnuf6qbk/u2doNp7CQ9zd0X0EfGjS4dCaBeE/Ut8kkx66Ij/syHe7r+nn3P/g==
X-Received: by 2002:a17:903:2286:b0:215:b087:5d62 with SMTP id d9443c01a7336-219e6f1483fmr906444755ad.36.1736176581698;
        Mon, 06 Jan 2025 07:16:21 -0800 (PST)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f72b8sm293558835ad.191.2025.01.06.07.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 07:16:20 -0800 (PST)
Date: Mon, 6 Jan 2025 07:16:18 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	horms@kernel.org, jacob.e.keller@intel.com, netdev@vger.kernel.org,
	vadim.fedorenko@linux.dev, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next v2 3/4] net: wangxun: Implement do_aux_work of
 ptp_clock_info
Message-ID: <Z3vzwiMzYDvmKisj@hoboy.vegasvil.org>
References: <20250106084506.2042912-1-jiawenwu@trustnetic.com>
 <20250106084506.2042912-4-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106084506.2042912-4-jiawenwu@trustnetic.com>

On Mon, Jan 06, 2025 at 04:45:05PM +0800, Jiawen Wu wrote:

> +static int wx_ptp_feature_enable(struct ptp_clock_info *ptp,
> +				 struct ptp_clock_request *rq, int on)
> +{
> +	struct wx *wx = container_of(ptp, struct wx, ptp_caps);
> +
> +	/**
> +	 * When PPS is enabled, unmask the interrupt for the ClockOut
> +	 * feature, so that the interrupt handler can send the PPS
> +	 * event when the clock SDP triggers. Clear mask when PPS is
> +	 * disabled
> +	 */
> +	if (rq->type != PTP_CLK_REQ_PPS || !wx->ptp_setup_sdp)
> +		return -EOPNOTSUPP;

NAK.

The logic that you added in patch #4 is a periodic output signal, so
your driver will support PTP_CLK_REQ_PEROUT and not PTP_CLK_REQ_PPS.

Please change the driver to use that instead.

Thanks,
Richard

