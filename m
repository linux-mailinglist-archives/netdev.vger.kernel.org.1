Return-Path: <netdev+bounces-224177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5ECB8196D
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 21:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18DA83AB17A
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 19:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B0E30C0FA;
	Wed, 17 Sep 2025 19:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="GV8rDsAm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254F02FB968
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 19:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758136825; cv=none; b=BggXKo2M/cejyfLTBF2ehql+2hGJAvdv3c1j/r27w5dbq+IbJFejWG+xfqzbW4rmStqLfoEZWbmd46+Y666DkCwb40oDZes2D06Paj5PcNnF3GdWXmdEPsRDmIafBrMcNVpAWom9buHQdVzuBYdjMjk9gMfjwraNHfa5LeyyA+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758136825; c=relaxed/simple;
	bh=yf5Y9YG2oLtvjs7wQ7MzVcyxI3AqukqgyzPKsUEW0oo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bKH2PQyNIATLc9u+pDN90nmmOdJWzvUMXWxp3UVJQ+X38MP81YS+CXB6YLXnHQp6KDZhFjQiQw7kmArhe+kZ/yrkv/irlODP/8Odlr1Fq9jrLE1occWnY3vYNjTzPxbvDTY6BioxgBINTikOc5jElHIGmNfnRYyPr8l4Lb7Ixco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=GV8rDsAm; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-71b9d805f2fso1554086d6.0
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 12:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758136822; x=1758741622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADTukD6B7RmHl8VVR//EKxw6ixi7COixouKBx3IfTSs=;
        b=GV8rDsAm8TkU35HbBKPXbW+oG3amqkDVTJ+MYuDs+WzJKbHyNH5g3uJnzDSKNHq8Ki
         Q3aQIF1ePUbG1GZccUzzltQKF1dwDHoKOCcAw5HhT8+gfnW9eiMHFFovCYdHzDnpPYw2
         2MCH4cfCao3dwlMzAA/qA2BJwX5k6T+fGJ5pruwwJfFpkOPyTbCf2V8NZ3k8E8vI5sb/
         IVTqRQj7xdp8+KR09ye/VdKg6TnJd8rBD/xFBF+u4lhCfyWEuXM5HZmop+JvDMJgAoeF
         wnY4SeCGNtim5VTs9jMg7/1dXggIltg+dX+ha4EkxrhZ4BEJTGKnoE0/Q5TZBYdmVV1U
         +30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758136822; x=1758741622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ADTukD6B7RmHl8VVR//EKxw6ixi7COixouKBx3IfTSs=;
        b=QHg0yCrqrWpO4S2NdzGQbpQ7PntisbelC4U6fN0w5i2GZaF0NQmaEirCWMUEmQdEez
         86E1zJG82rFzB/ETatTr+UrY2Rz0URLX8SvEn3sNP5XNn6oOwagSOgEBQEfdqKX9UkGU
         SJBzQpmN4O97YDBX02y4wXENQVIpBhVM/Q23wrj9DPt0ri9SpKApbEg4sCnFX0azxn/v
         ZH7apzv0sT4k7ES+QKuI0mWBKdWm2+aEX1by79zjSx+xsD0N0IzT3DQQvhgDDLIdLkXF
         NdvTGq9LX8FspzVi9ghm5xMF8V03k6tx1iIsefQWniXaLyB/kxKGkRrOEQaOvRb2L0Ly
         INVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHfO8CK4O9TCvX4RJ7MqEpJYPbBHqLyUsxIir7TXa5jMSoojqXqW6llggcQ0DqcF+ZkxPrY9c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/i3W+rnnHxEXgR5bfQxQkVcWbSSO35ZeOnK6vKFMxkO9B96By
	t9BMaFW0BG3q083knkT9qtggA5esOgz3NJ91ltb+ZcKyk+frCeMAWrIjZOhf0cm+xRHwZiQ8q0n
	tYo0z
X-Gm-Gg: ASbGnctcirhhb4oW6p3QXv93OGHjRVSFdCv8e+CN9XBz+xJV4sk62NapyYphhhRZ+dT
	+imWo0Sa7I933F+19OAuzrFFqXjC4pRW0gvAqV58hxWLX0/evT7HCTM7SKLMM9iYETEb5c1UQQk
	Sslc+hOL7vkyidTqOvJEJtNmkFZb/jv/YoRPxHay5S+MI5I57xLSuyvxTCpA4wwnatyAy8AOGuv
	EqT27Sv9vc1OEj1I0YLFQIQVLOqS5voXvowuaIL2c5bpEauXHVXok5pbRmA6f+hhflixvWBGpxi
	aVrhQ7MBMhimi6PYjjJSW35VqTYkhMUA3L7OD0TxIu/a8QZP0G1pohrVPMZQT6v6rVf+Htg+K/h
	fo7tEqFAezWbQKJqgzeFPm0YbHAxkylQjn+HLb94e2K1bBQBk41hh0dUlJHIyBvMZbqDpUXgmqG
	4=
X-Google-Smtp-Source: AGHT+IG12vBilRC+cgBC1jCZkudS7dmyFjCdSCbkSVm0/Gtt5e9SMEtssx9m8PysHelzuij9pJgwiA==
X-Received: by 2002:a05:6214:b6b:b0:725:29f0:c7c8 with SMTP id 6a1803df08f44-78eced22fc2mr43150376d6.47.1758136821985;
        Wed, 17 Sep 2025 12:20:21 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-793446acfa6sm990666d6.14.2025.09.17.12.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 12:20:21 -0700 (PDT)
Date: Wed, 17 Sep 2025 12:20:18 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Alasdair McWilliam <alasdair@mcwilliam.dev>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, Daniel
 Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH iproute2-next] ip: geneve: Add support for
 IFLA_GENEVE_PORT_RANGE
Message-ID: <20250917122018.40ee1cbe@hermes.local>
In-Reply-To: <20250917162449.78412-1-alasdair@mcwilliam.dev>
References: <20250917162449.78412-1-alasdair@mcwilliam.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Sep 2025 17:24:49 +0100
Alasdair McWilliam <alasdair@mcwilliam.dev> wrote:
> @@ -142,6 +143,22 @@ static int geneve_parse_opt(struct link_util *lu, int argc, char **argv,
>  			    (uval & ~LABEL_MAX_MASK))
>  				invarg("invalid flowlabel", *argv);
>  			label = htonl(uval);
> +		} else if (!matches(*argv, "port")
> +			|| !matches(*argv, "srcport")) {
> +			struct ifla_geneve_port_range range = { 0, 0 };
> +

Do not use matches(), it leads to confusion because of duplicate prefixes.
It is only allowed in legacy iproute parts. I.e no new additions.

> +	if (tb[IFLA_GENEVE_PORT_RANGE]) {
> +		const struct ifla_geneve_port_range *r
> +			= RTA_DATA(tb[IFLA_GENEVE_PORT_RANGE]);
> +		if (is_json_context()) {
> +			open_json_object("port_range");
> +			print_uint(PRINT_JSON, "low", NULL, ntohs(r->low));
> +			print_uint(PRINT_JSON, "high", NULL, ntohs(r->high));
> +			close_json_object();
> +		} else {
> +			fprintf(f, "srcport %u %u ", ntohs(r->low), ntohs(r->high));
> +		}

Do not use fprintf directly instead use multiple calls to print_uint like:

		open_json_object("port_range");
		print_uint(PRINT_ANY, "low", "srcport %u", ntohs(r->low));
		print_uint(PRINT_ANY, "high", " %u ", ntohs(r->high));
		close_json_object();

Avoid having json specific code with is_json_context() if possible.
It leads to untested code paths.


