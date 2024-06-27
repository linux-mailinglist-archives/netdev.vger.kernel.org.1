Return-Path: <netdev+bounces-107400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8AF91AD49
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 18:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 081EF283055
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 16:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C07C199E9D;
	Thu, 27 Jun 2024 16:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="zlh3ocbV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D20199E95
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 16:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719507408; cv=none; b=sWBTyGvcjXpr/4oNtLwZcdHUDiZ/Lwbbz4I5M7I7mFvxo9q/aJam8zjNFXRBdlNzCvj2wHcZfwrOe6WGY1wKhxRmeZHfiR+bOU8INxDKwFUNjYP7mKvD/3V2TfezX93jKxDHWRwkTbRN80nmErPs9xYUUhUZWH75hBimw9KuxR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719507408; c=relaxed/simple;
	bh=sGRHvNNBQqHWd0kGSpLIXkHaP+NCiElP4Rbwodj5EWM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ndxVg8RyTEwoZ3whyFrWOCWQZjeFY7mOgIn58HAdDVe+S0dODW2bCwY8O4zv+/15Y4pmRGCNu6X2YNOsOZRpZVHBjgnOCpSpgiM88LIaHJduDGOJM47raDZQq3Pb1rlC5tQIGR7r+FYSfsZjc0KcVaPSUpxsquoHid+7JJwbpvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=zlh3ocbV; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-701f3ca4c8aso282090a34.1
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 09:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1719507405; x=1720112205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rxJfHlTinmEklgjjAHmv5krtYkzMpsTkKBhHunprux0=;
        b=zlh3ocbVb9WOOR3Ho3EBEdW/cf4gXQabNN/Y+GvB54yDSQCikUT0kV78YXTHoRcwYQ
         FyDD+DIPESjGF0sG3c/3HaDJAUSniwB7o4X1Tk6U+ZSDhekl9GH7QunTYbbDy+McY5Y5
         boXE1+qv9D+s6q3rR0uApUW5/C1HvCIAIoDQGRHNVQ2PN51uWO2xxuiMFQaK+4xKLDpO
         9hfxfdqa1MtFqXpGtM2biqO5rBhXGO+UuQDKQo3zVmgOiBMAjZArC8ibfQ+s/RKJn2J7
         yApXrZePPBsr9AhHGH8ObRdSYDHk08TQcfvadk3IiW6KCFiaIXDZFPuoFClHpxpNBRy6
         97Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719507405; x=1720112205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rxJfHlTinmEklgjjAHmv5krtYkzMpsTkKBhHunprux0=;
        b=WU52DpPabI4zq0ObDFvOPlq5+jYgRO1B3yT9ZM94HpB87iBmbwT/B0uumiQm9Sa0t9
         iq4HznibYpxPNYYMCpec0LXB/tzDptcagrSICarJaGENPykg1FGIAYeLZKTYlEaDG2y6
         Hx+8boAzrIzyh5pCLURly3hHRnBr856Y6fcenSOsza7HVjAFOiGTp6cWIHA5eS9UARTO
         LAQdlXi5MlFThD/mcGhHwKvoMtupNJUXlToHFhlylRce8uIL/xL/r3d8mMXfZJYWycv3
         XJFGBktbeMcsc8IJ8MaDrs1E37pio+oHEbUrZuRHi+Atu85kaJTgrG01vXL0T5YcpzkQ
         f+CQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdHGbCY3aSyQg78RMinjEDz4sNq42SeG6tGdMAGaFDFQxZTIu/YSWUL02fy+vjwqF06A0stybjxXKPChFYDVwf/g/g/WBh
X-Gm-Message-State: AOJu0YyQ2zpFGh1oGjhSnk0GrzwBW0ZtyGQCsu3jqwrrs3NPvHFBS/TB
	zTsZ8i21khkfXDWCCOe4VVIP2C6LbZGwadQ11taZkyzA6VvtpnR6tv6oGbbhSGs=
X-Google-Smtp-Source: AGHT+IFnSnYsmkz78llEaBbXHgGTzyZZs8c4Z8xW0/QdPFqHLmlg/PCcspy1iX6UbZjiYHNXpceH4A==
X-Received: by 2002:a05:6870:610e:b0:25d:7840:436f with SMTP id 586e51a60fabf-25d784048c4mr1709699fac.48.1719507405424;
        Thu, 27 Jun 2024 09:56:45 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706b4a5bc11sm1583675b3a.210.2024.06.27.09.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 09:56:45 -0700 (PDT)
Date: Thu, 27 Jun 2024 09:56:43 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: dsahern@kernel.org, liuhangbin@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH v2 iproute2 3/3] bridge: mst: Add get/set support for
 MST states
Message-ID: <20240627095643.77dc2177@hermes.local>
In-Reply-To: <20240624130035.3689606-4-tobias@waldekranz.com>
References: <20240624130035.3689606-1-tobias@waldekranz.com>
	<20240624130035.3689606-4-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Please resolve the following issue.

> +static int mst_set(int argc, char **argv)
> +{
> +	struct {
> +		struct nlmsghdr		n;
> +		struct ifinfomsg	ifi;
> +		char			buf[512];
> +	} req = {
> +		.n.nlmsg_len = NLMSG_LENGTH(sizeof(struct ifinfomsg)),
> +		.n.nlmsg_flags = NLM_F_REQUEST,
> +		.n.nlmsg_type = RTM_SETLINK,
> +		.ifi.ifi_family = PF_BRIDGE,
> +	};
> +	char *d = NULL, *m = NULL, *s = NULL, *endptr;
> +	struct rtattr *af_spec, *mst, *entry;
> +	__u16 msti;
> +	__u8 state;
> +
> +	while (argc > 0) {
> +		if (strcmp(*argv, "dev") == 0) {
> +			NEXT_ARG();
> +			d = *argv;
> +		} else if (strcmp(*argv, "msti") == 0) {
> +			NEXT_ARG();
> +			m = *argv;
> +		} else if (strcmp(*argv, "state") == 0) {
> +			NEXT_ARG();
> +			s = *argv;
> +		} else {
> +			if (matches(*argv, "help") == 0)
> +				usage();
> +		}
> +		argc--; argv++;
> +	}
> +
> +	if (d == NULL || m == NULL || s == NULL) {
> +		fprintf(stderr, "Device, MSTI and state are required arguments.\n");
> +		return -1;
> +	}
> +
> +	req.ifi.ifi_index = ll_name_to_index(d);
> +	if (!req.ifi.ifi_index)
> +		return nodev(d);
> +
> +	msti = strtol(m, &endptr, 10);
> +	if (!(*s != '\0' && *endptr == '\0')) {
> +		fprintf(stderr,
> +			"Error: invalid MSTI\n");
> +		return -1;
> +	}
> +
> +	state = strtol(s, &endptr, 10);
> +	if (!(*s != '\0' && *endptr == '\0')) {
> +		state = parse_stp_state(s);
> +		if (state == -1) {
> +			fprintf(stderr,
> +				"Error: invalid STP port state\n");
> +			return -1;
>

Building with clang shows this problem.


    CC       mst.o
mst.c:215:13: warning: result of comparison of constant -1 with expression of type '__u8' (aka 'unsigned char') is always false [-Wtautological-constant-out-of-range-compare]
                if (state == -1) {
                    ~~~~~ ^  ~~
1 warning generated.


