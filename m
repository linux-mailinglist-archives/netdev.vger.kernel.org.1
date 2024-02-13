Return-Path: <netdev+bounces-71161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0A48527F1
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 05:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F9CCB214F0
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 04:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB898A947;
	Tue, 13 Feb 2024 04:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="g3jTtfh5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8EBA923
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 04:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707797774; cv=none; b=GtThJbiW0wz3MaOUSGeK084dOfEM/JS5Xjeaj624Kwe/DVe+Xq8FBOCBj+jBGAS4CEwH+OyyxtKgcovrdcPIjrdWCp+D0M/0w7nya/pPbjrQ8DIT7BF920cRoLw5rFKgQsKrb3THHBE0yGXgNqCUrjoQwptPjF/4iQVa2tgp/2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707797774; c=relaxed/simple;
	bh=7KvBBG4vXrA8h6JrjVp+iNCiRqnw77QDviDTPYbaXKc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AJkLWoEkuGGWhHK2FkZCbF7x0CfDqWdl1UkxlPxd9OiT3JKp0WLe5zYEXqBP3ziJMnUJnFXJPgaJqe6+d2MKGOWljw7SXpTU8e2XViQIOhfmfJZIY3w7nJgCgujlbLU6WF1iebGmmI3BHONEkBGAnUMbVorGkZm0MwQQyEWT0S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=g3jTtfh5; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c02b993a5aso2165678b6e.1
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 20:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1707797771; x=1708402571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IMkBWNtovIXtD/h0b9uuX4Jj6Vca2YwFTW923gsNueo=;
        b=g3jTtfh5cRs2VkeuXnYlF+zW7wxKN6Uzyjd/xvWJ+uksAaPQg0SuzGMsOh1PLeHRCF
         yrPfceCsBbOo23Uc3XeS/heK8V8MBJpjZBJ9adfkYQlsji7m4fEkWn54urh/ZBSrVd4b
         qIxIItPfYcPOwexb+JIdNHM81ARlWLrTwOIQjPEUNSL1Lw+lEIUnvTGa4DIdA6cNVuFB
         BelrfDn4QCLJVTLwGs3JwUKXs80FzSykaq5TUHPeAFCuvMD0egX7e6GSvq/44XpI9d5b
         /iRUsRAaEu1c7yG1lY2htAEoCH7j3JO7EEHmtDAa53DaG1jH6nyzJj4rH6OMRvXfOyeQ
         pZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707797771; x=1708402571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IMkBWNtovIXtD/h0b9uuX4Jj6Vca2YwFTW923gsNueo=;
        b=UqwE1WAz9xSbXDJ9i7vajAGZUHyIXMgVaqTRwRJ2WrgWTg+VKpHOtKsW3ZlaF/8YzD
         NUPf3JNhUGD9uov2NrTm8/eebYw65Vu8oGQGttBN34nV3iVZFzy4JSKQ33XDavBTN+cm
         c3NhDo80BqWarS2EoeBktRwIuIMyLBZlruJ8xMLOCCVkevblmpmUynEIrmYX87mLIBkn
         fe05W+p47TxfNWGAwFL7ZLV+VrNn1RCwFmYIEJ1A4nXnnErBzXRi58DcZV1mr0ou4Hoc
         V9J8ULiIZPwd+AxeSXGEGdn7Lt0y9iwvCQw1stEXOCgHV5++seWgYUE33g/x3Y6etq+H
         8kwQ==
X-Gm-Message-State: AOJu0YxgNKJCvVVGkgmowMJlJUNCXRkoqzyye0U7YT/+gN8aRt4YV3dG
	Tasu0t0foLLZeYZHo/uFJsgqxGFE7CK52IlNw0G8QkKfjadp7MLumaqyHWwrKomG5IKzWWj9us9
	u
X-Google-Smtp-Source: AGHT+IHwfuCuGeeW3wTfGdoFPTtQs8j8sNx3uKLGAvbd3OH66840gWZBEMEWIQbVCY3M69K3S9BhJQ==
X-Received: by 2002:a05:6808:3995:b0:3c0:3b90:ae24 with SMTP id gq21-20020a056808399500b003c03b90ae24mr4547082oib.24.1707797771455;
        Mon, 12 Feb 2024 20:16:11 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id k15-20020a62840f000000b006dd843734c8sm6653950pfd.81.2024.02.12.20.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 20:16:11 -0800 (PST)
Date: Mon, 12 Feb 2024 20:16:09 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Takanori Hirano <me@hrntknr.net>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] tc: Support json option in tc-cgroup, tc-flow and
 tc-route
Message-ID: <20240212201609.7ac78134@hermes.local>
In-Reply-To: <0106018d95ad56f9-e076853c-3bd4-485e-b2ab-ae85e1f0d65e-000000@ap-northeast-1.amazonses.com>
References: <20240210092107.53598a13@hermes.local>
	<0106018d95ad56f9-e076853c-3bd4-485e-b2ab-ae85e1f0d65e-000000@ap-northeast-1.amazonses.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 11 Feb 2024 00:59:41 +0000
Takanori Hirano <me@hrntknr.net> wrote:

> +	if (tb[TCA_ROUTE4_TO]) {
> +		open_json_object("to");
> +		print_string(
> +			PRINT_ANY, "name", "to %s ",
> +			rtnl_rtrealm_n2a(rta_getattr_u32(tb[TCA_ROUTE4_TO]), b1,
> +					 sizeof(b1)));
> +		print_uint(PRINT_JSON, "id", NULL,
> +			   rta_getattr_u32(tb[TCA_ROUTE4_TO]));
> +		close_json_object();
> +	}
> +	if (tb[TCA_ROUTE4_FROM]) {
> +		open_json_object("from");
> +		print_string(
> +			PRINT_ANY, "name", "from %s ",
> +			rtnl_rtrealm_n2a(rta_getattr_u32(tb[TCA_ROUTE4_FROM]),
> +					 b1, sizeof(b1)));
> +		print_uint(PRINT_JSON, "id", NULL,
> +			   rta_getattr_u32(tb[TCA_ROUTE4_FROM]));
> +		close_json_object();
>  	}

Both to and from don't need to be sub-objects, simpler to just print
as to and from. Also, avoid unnecessary line breaks in source.

		print_string(PRINT_ANY, "from", "from %s ",
			     rtln_rtrealm_n2a...

> +		print_string(
> +			PRINT_ANY, "fromif", "fromif %s",
> +			ll_index_to_name(rta_getattr_u32(tb[TCA_ROUTE4_IIF])));

This looks like a good place to add color:
		print_color_string(PRINT_ANY, COLOR_IFNAME, "fromif", "fromif %s",
				   ll_indext_to_name...

