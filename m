Return-Path: <netdev+bounces-78266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEC687497F
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 09:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB099B219B9
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 08:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2A163410;
	Thu,  7 Mar 2024 08:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RgZVpI2a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578671CD09
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 08:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709799787; cv=none; b=tJlyAVFDWR2ZkPQs7GKLXQN5+B79Nifah4z9fUoj56evGU7w85X9z2Mh/1ANvvc/47KQPi8Cts0SGLhZqBSEPY/WAHuLesMiyXn1W7zsHjPvStIPUbYq2+SHhczwmmCQsNqRVNvuKQalz/YoLLh46SqU7LLLEDfV3X2+5dRfuZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709799787; c=relaxed/simple;
	bh=c7DU7j1T11TpDZaT0tyl9BIJh8qXovMj5Xh/pKI1SjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gu7AZJmQY8sf4xLIUzCcpF1S2Cu5b8aYTXy3Br1yv7zHJ882N3km4t9KBljXDFEeRhAixyvz/+J7SDeiU4NKzPFH+nPGigBlz3v9glO+Z+EFPfMvWZU5uKpw4pYqyrXIysikISXYDBGdGh5z8TA7qFFvRJlQL8ws6usdcFu/cFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RgZVpI2a; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-609eb2cbeccso5949997b3.2
        for <netdev@vger.kernel.org>; Thu, 07 Mar 2024 00:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709799784; x=1710404584; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BTCDlQMgEr5UEnpV5mDn3dJxhyjjt0R5yPNztDHuRWA=;
        b=RgZVpI2am6/GI15D1D4hI8zwL8t0VmcPmEejTBQpsiE8+uEUjS8UmS8kuf324X76Mw
         ONy+yYJHOCT6yYbCB9VHBPEKZoVkyEPibwDbzGPjV+bppR8YNjW2FQF0NgY7lHM5dcCP
         IkrF3m/OqYv0yNU+p8llY/cDUWDQejUluw+C6b31jrCDBfHOHDHQ9Ai5WFhPTW2kp7XH
         wo4Kq5Kh9GmQafI1OZ5cjx9bsz9DVcsvShpoZqSbrWwTSOxXAkUMe4KIjW+ZELr2p2Lz
         +NHrs+dbw/qAx6K6Q4KpMxU12nq+tY+uZ5KUGr+fePYo312vdlrStCOoSiAo7hlhZLaE
         vBTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709799784; x=1710404584;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BTCDlQMgEr5UEnpV5mDn3dJxhyjjt0R5yPNztDHuRWA=;
        b=jRpBWAbI9W50VTdCv1LdNqBNjFtFi7V4oFOcFF8WWE6zTL9cGIeDdNgDmPtIgVxM5U
         q4gdBgevB9FahlHCHR7AZ3JbbQzCiXcxlPjmhMoyxPvwufgvRDzgfCKJWUtFwsWOEZuD
         yXobJYkT/PqoWEUlUmTdghPdLvajhMNptvazmfccNRQRAqBrUAjpU6oxcHrIq3H24T5z
         q+s+d6lqrQoN1mRvPPwIUXeGsiEvWRgX1D5C/8kNEKD3gh+4ESGLLyaAuljcCn3Y3wNT
         AXNdU58zPJqbmwqaX22wDXLYK5SKvW1Urg4wdJL+f89nWjonf5zp5cbliPc/NEuY2kYP
         WAnA==
X-Forwarded-Encrypted: i=1; AJvYcCVI6cVzjBN+v8K9cwvYuhFYpM27Zffzo9PfDIL+LOOExEkDoVtWLvHBG3mLye8CLsIMMBdXMWGOiLm9KHKpycQwY4OA0kUD
X-Gm-Message-State: AOJu0YzUUdQ+4bb6IMQa1Hzw2cHly9zF06EPpnWsgVKlwUy5a8RKhxwt
	cE2YE5VzQ+TTTJY0wByR3BBOlXj6N0FSJWFspka0vGzlC1UDGDRl8VETbhiH+5PpI5ndcFYd8lb
	YYaQnh906VVA6v8i+epaGxJFlkgmozU/+whG6dg==
X-Google-Smtp-Source: AGHT+IGtlINLMOBpnSyCH2ZmpwWY+N46YIj+jpgvXOKi2Jcaj1+sVPOFaJ/lVWVfwLTv+DvW59tvQrS42RXoxx6CtmY=
X-Received: by 2002:a0d:d882:0:b0:607:834f:b4c4 with SMTP id
 a124-20020a0dd882000000b00607834fb4c4mr1560071ywe.29.1709799784322; Thu, 07
 Mar 2024 00:23:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306-wcn3990-firmware-path-v2-0-f89e98e71a57@linaro.org>
 <87plw7hgt4.fsf@kernel.org> <CAA8EJpr6fRfY5pNz6cXVTaNashqffy5_qLv9c35nkgjaDuSgyQ@mail.gmail.com>
 <87cys7hard.fsf@kernel.org> <CAA8EJpowyEEbXQ4YK-GQ63wZSkJDy04qJsC2uuYCXt+aJ1HSOQ@mail.gmail.com>
 <baa7a017-ee4b-4e8f-9bb8-1e3857e18855@quicinc.com>
In-Reply-To: <baa7a017-ee4b-4e8f-9bb8-1e3857e18855@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 7 Mar 2024 10:22:53 +0200
Message-ID: <CAA8EJpq780+=b-XEShsS4ixtpOJxwigvR-E0nPJ1Xz0CV_eO4Q@mail.gmail.com>
Subject: Re: [PATCH RFC v2 0/4] wifi: ath10k: support board-specific firmware overrides
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Kalle Valo <kvalo@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	ath10k@lists.infradead.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Mar 2024 at 00:25, Jeff Johnson <quic_jjohnson@quicinc.com> wrote:
>
> On 3/6/2024 6:23 AM, Dmitry Baryshkov wrote:
> > After some thought, I'd suggest to follow approach taken by the rest
> > of qcom firmware:
> > put a default (accepted by non-secured hardware) firmware to SoC dir
> > and then put a vendor-specific firmware into subdir. If any of such
> > vendors appear, we might even implement structural fallback: first
> > look into sdm845/Google/blueline, then in sdm845/Google, sdm845/ and
> > finally just under hw1.0.
>
> are there existing examples in linux-firmware?

Yes. QCM2290 / QRB4210 platforms have "updated" wlanmdsp.mbn file,
which actually prompted us to work on these overrides. I have opened
the MR against linux-firmware, marked as draft for now, until all
discussions are finished:

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/165

> or is the whole point being only the default firmware is in
> linux-firmware and vendors would follow this pattern if they add their
> own firmware?

Unfortunately not.

-- 
With best wishes
Dmitry

