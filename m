Return-Path: <netdev+bounces-137669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B689A93EB
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 01:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 263FA1F23440
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 23:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964EF1FF5FD;
	Mon, 21 Oct 2024 23:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="1pDlsHQ2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F591FF601
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 23:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729552099; cv=none; b=myCgG5Qr7dQFVJyF49DKnuM3nWq+YoOPgB43qmVIDrd60+PNT4Clv20pjlP7fyT7KVukVC1UvzpcF/M+2zTZoDs5oXw50N2RJ8030oYI1kbfYdt241OvfSqG/uy8VldorPDc438oPr+Fjjv+73nQkZQzVoFOTQyJy+978Pb29cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729552099; c=relaxed/simple;
	bh=6wopLBuvhdufEgiem7blYdrXlu4zNN7U9YSrw03bKJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=doS9tGJHEC7pf40ix8QTXmqj3AVCvqIBMjPy6w/d+BtrofGFtQPov2qQm4Ri52viRPlDPX8hcF8rg7GMKJiMxEqLm6e82nWATH3vNLZb3iZafQQIAxp9qYV4UijbVMgI6pJOb0gZc/1+qXCucCVCrdJCtbUw4wVXOYXUeX2Rx5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=1pDlsHQ2; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71ea2643545so3112261b3a.3
        for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 16:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1729552097; x=1730156897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5UOzsW4lB9UR8TRgJDftWEkKwl7aQRTeipJxNmdaQo=;
        b=1pDlsHQ2u7OLvNDlxQXAVUbIOuUxzO7utGMrb3SqMvG6DCh8zYY4Oa55OB0fTJBMhA
         gTTOKoVw08WmuvvXtF7GVlKAiEnJhsIH2QgrIkl4LRcNqD9P1kAjJhhaYO1kyCpL9gak
         MNVG62gbWCGlqu3I3Zkw1VON74TD+hY53HlKilCfv4gA8ly7tCUUMcwufvPuuoqF5+P6
         1YtkfUVfJ8SvBfEZGLs3uWv/rl0y2hqqSxRQ680MPE5lVmk+RPvJ0HkAreRWtLBz03fy
         xXT8yVbO5YPJkBdYsSft69BYHF4Na7oGK+zAhA5sb79AHloyy0g4cFBeWEDBvYqQQio7
         k4Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729552097; x=1730156897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5UOzsW4lB9UR8TRgJDftWEkKwl7aQRTeipJxNmdaQo=;
        b=KE7YpFo+DVdqYBl7JKDF8PHML5ZH58cKa7JsB+1DUTC1SQBMefkvCvckDEYwQXkcDH
         purUYXMq/4OKK+ttpv6ssTjqenn7+hDz6wUpPrZHpAj04KbqKxCXetY/mXCQU3vo2K15
         +4W6sqkaG4zFmxNMMLbA0dA4n3iT/yy+/sBihmHDb8MHc7yQaDUoTf34Tg4Ag9VqLYpT
         iqrOug2XHM0cM8zqDXbLszNwDZwl4x4HcZR7uHavqksSWflW1G19YDvOeLokl1KWiq54
         tGRWJS3Mys2+uSrlAd0LjfDCtOVaxYNYO9Vt7Ly7wq9lrdOxjoxwIgkk8nRoTvdIZKOL
         j26g==
X-Gm-Message-State: AOJu0YwFHxTZFOho+IFXgStjA2SAcQC1gNRftsCn8hE3o8wmnDHdp48w
	7u7SrR8wUGlx3R8Te49SVHMi8OAXy7XCBJj04yr5ZlYnSF1KJwiFqtJnrQ6PIgA=
X-Google-Smtp-Source: AGHT+IG3edN+uEx1pS4N/esr4mthD1IiGhRHmQV2Um9DUZZrFRowOn0fRBr+Nlj6dSjIImsj4WS6SQ==
X-Received: by 2002:a05:6a00:2302:b0:71e:5a1d:ecdc with SMTP id d2e1a72fcca58-71ea31d2c22mr18714284b3a.17.1729552097182;
        Mon, 21 Oct 2024 16:08:17 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeabb91b5sm3147040a12.73.2024.10.21.16.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 16:08:17 -0700 (PDT)
Date: Mon, 21 Oct 2024 16:08:15 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: chia-yu.chang@nokia-bell-labs.com
Cc: netdev@vger.kernel.org, dsahern@gmail.com, davem@davemloft.net,
 jhs@mojatatu.com, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com, Olga Albisser <olga@albisser.org>, Oliver Tilmans
 <olivier.tilmans@nokia.com>, Bob Briscoe <research@bobbriscoe.net>, Henrik
 Steen <henrist@henrist.net>
Subject: Re: [PATCH iproute2-next 1/1] tc: add dualpi2 scheduler module
Message-ID: <20241021160815.4516f322@hermes.local>
In-Reply-To: <20241021221559.60411-2-chia-yu.chang@nokia-bell-labs.com>
References: <20241021221559.60411-1-chia-yu.chang@nokia-bell-labs.com>
	<20241021221559.60411-2-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Oct 2024 00:15:59 +0200
chia-yu.chang@nokia-bell-labs.com wrote:

> static int dualpi2_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
> +{
> +	struct rtattr *tb[TCA_DUALPI2_MAX + 1];
> +	uint32_t tupdate;
> +	uint32_t target;
> +	uint32_t step_thresh;
> +	bool step_packets = false;
> +
> +	SPRINT_BUF(b1);
> +
> +	if (opt == NULL)
> +		return 0;
> +
> +	parse_rtattr_nested(tb, TCA_DUALPI2_MAX, opt);
> +
> +	if (tb[TCA_DUALPI2_LIMIT] &&
> +	    RTA_PAYLOAD(tb[TCA_DUALPI2_LIMIT]) >= sizeof(__uint32_t))
> +		fprintf(f, "limit %up ",
> +			rta_getattr_u32(tb[TCA_DUALPI2_LIMIT]));
> +	if (tb[TCA_DUALPI2_TARGET] &&
> +	    RTA_PAYLOAD(tb[TCA_DUALPI2_TARGET]) >= sizeof(__uint32_t)) {
> +		target = rta_getattr_u32(tb[TCA_DUALPI2_TARGET]);
> +		fprintf(f, "target %s ", sprint_time(target, b1));
> +	}
> +	if (tb[TCA_DUALPI2_TUPDATE] &&
> +	    RTA_PAYLOAD(tb[TCA_DUALPI2_TUPDATE]) >= sizeof(__uint32_t)) {
> +		tupdate = rta_getattr_u32(tb[TCA_DUALPI2_TUPDATE]);
> +		fprintf(f, "tupdate %s ", sprint_time(tupdate, b1));
> +	}
> +	if (tb[TCA_DUALPI2_ALPHA] &&
> +	    RTA_PAYLOAD(tb[TCA_DUALPI2_ALPHA]) >= sizeof(__uint32_t)) {
> +		fprintf(f, "alpha %f ",
> +			((float)rta_getattr_u32(tb[TCA_DUALPI2_ALPHA])) /
> +			ALPHA_BETA_SCALE);
> +	}
> +	if (tb[TCA_DUALPI2_BETA] &&
> +	    RTA_PAYLOAD(tb[TCA_DUALPI2_BETA]) >= sizeof(__uint32_t)) {
> +		fprintf(f, "beta %f ",
> +			((float)rta_getattr_u32(tb[TCA_DUALPI2_BETA])) /
> +			ALPHA_BETA_SCALE);
> +	}
> +	if (tb[TCA_DUALPI2_ECN_MASK] &&
> +	    RTA_PAYLOAD(tb[TCA_DUALPI2_ECN_MASK]) >= sizeof(__u8))
> +		fprintf(f, "%s ",
> +			get_ecn_type(rta_getattr_u8(tb[TCA_DUALPI2_ECN_MASK])));
> +	if (tb[TCA_DUALPI2_COUPLING] &&
> +	    RTA_PAYLOAD(tb[TCA_DUALPI2_COUPLING]) >= sizeof(__u8))
> +		fprintf(f, "coupling_factor %u ",
> +			rta_getattr_u8(tb[TCA_DUALPI2_COUPLING]));
> +	if (tb[TCA_DUALPI2_DROP_OVERLOAD] &&
> +	    RTA_PAYLOAD(tb[TCA_DUALPI2_DROP_OVERLOAD]) >= sizeof(__u8)) {
> +		if (rta_getattr_u8(tb[TCA_DUALPI2_DROP_OVERLOAD]))
> +			fprintf(f, "drop_on_overload ");
> +		else
> +			fprintf(f, "overflow ");
> +	}
> +	if (tb[TCA_DUALPI2_STEP_PACKETS] &&
> +	    RTA_PAYLOAD(tb[TCA_DUALPI2_STEP_PACKETS]) >= sizeof(__u8) &&
> +	    rta_getattr_u8(tb[TCA_DUALPI2_STEP_PACKETS]))
> +		step_packets = true;
> +	if (tb[TCA_DUALPI2_STEP_THRESH] &&
> +	    RTA_PAYLOAD(tb[TCA_DUALPI2_STEP_THRESH]) >= sizeof(__uint32_t)) {
> +		step_thresh = rta_getattr_u32(tb[TCA_DUALPI2_STEP_THRESH]);
> +		if (step_packets)
> +			fprintf(f, "step_thresh %upkt ", step_thresh);
> +		else
> +			fprintf(f, "step_thresh %s ",
> +				sprint_time(step_thresh, b1));
> +	}
> +	if (tb[TCA_DUALPI2_DROP_EARLY] &&
> +	    RTA_PAYLOAD(tb[TCA_DUALPI2_DROP_EARLY]) >= sizeof(__u8)) {
> +		if (rta_getattr_u8(tb[TCA_DUALPI2_DROP_EARLY]))
> +			fprintf(f, "drop_enqueue ");
> +		else
> +			fprintf(f, "drop_dequeue ");
> +	}
> +	if (tb[TCA_DUALPI2_SPLIT_GSO] &&
> +	    RTA_PAYLOAD(tb[TCA_DUALPI2_SPLIT_GSO]) >= sizeof(__u8)) {
> +		if (rta_getattr_u8(tb[TCA_DUALPI2_SPLIT_GSO]))
> +			fprintf(f, "split_gso ");
> +		else
> +			fprintf(f, "no_split_gso ");
> +	}
> +	if (tb[TCA_DUALPI2_C_PROTECTION] &&
> +	    RTA_PAYLOAD(tb[TCA_DUALPI2_C_PROTECTION]) >= sizeof(__u8))
> +		fprintf(f, "classic_protection %u%% ",
> +			rta_getattr_u8(tb[TCA_DUALPI2_C_PROTECTION]));
> +
> +	return 0;
> +}

Print function must use the JSON helpers

