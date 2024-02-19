Return-Path: <netdev+bounces-73034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFEA85AA8F
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 19:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DC311C20BD0
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 18:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA2947F79;
	Mon, 19 Feb 2024 18:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="0dKUI2FS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811EB4779F
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 18:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708365986; cv=none; b=V16yc6sFGm6HIFnBJJ2NsltwhpYQaPPe2Cb7Ybccf5xHWyaNgBCteG8+zmnKlD84ezcfjKtQ56q5NGcsOTjJg6xwafioNcZ/uuTDA+w5Zjp+mK3KdX4iySGhPPe2eptCp+hndNE7u2tMuJDGVXxENuXf2UR0sRA0rvaSaDFvqlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708365986; c=relaxed/simple;
	bh=rok4iSGln+4EvPqlE1p99GysN80CHct4S4ZW3DKNx2k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GFZ0h53opEiO2VvARSk67cENiOn5OeBG3XLnUNaBIHY0n5QX+5koNPU5MGQuuwStlfFP5MlF4D8X/fr4x9DHDQmaAqoEqma9F89fx2Kuz6BAYh/+aHebKA6zGYTUYhSr/4+n0SG6Fec5Mg5D7gaf+abEBJh7glk9Xrse8Xakj6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=0dKUI2FS; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6da4a923b1bso3863320b3a.2
        for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 10:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1708365984; x=1708970784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iU423KUKcJ1x4wKctn/rkdddR4VU91hmzlKkWF8B+m8=;
        b=0dKUI2FSN6UOoAdE5+OY/lhA2y4PMVnj3SUBX+lXyVu36ZBjd01hidq3LCsJ7bgzDY
         U/u6uH9GqESFTXID6GvvBSI5PjdlA/EM5IsXSt0mZN41DC9ARj4jNews4+REDlJ6KcDE
         4Nsbdm2H1gmsjETx4TXntgV1oJR6KAJRh77SLv87pbeutJ78A4TAUVkrJaukiEjmv1UP
         4k3aiCufKzDfYVjLq0d9AgBF/vTZsLz6OoneT+/bjnFKo+GjGcqRbOqH0AdXMXeHNzZB
         G4HYskjzUK+GZjI/x945CPYkBIbKGJHoTlUnl7/e/g1YccBkNZZjDMA5pG/tuS1lh3Ii
         bkig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708365984; x=1708970784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iU423KUKcJ1x4wKctn/rkdddR4VU91hmzlKkWF8B+m8=;
        b=Znw+NQXPBxbe+jxPM/l4tlqeIXBDPlvLF4Kow6GUz7KNOO0DI3wEhRI47l4eA1H1xj
         X4v7uZfnMcsEM1R9927ezWfFEl2kiIIkqi1jEUerr4hF4OafJV/GdTlUHehoCwNEhMSW
         qO3l52BIts8iMyVUX+qyQ8dh7kq2TTxoUoeh6kF8cJG0L+xYyI/es0zKi2O4njVYHLFI
         H08l9Nx4VzF5SZDZcydNtkirYNuoLTx6bMTnZjtBl+OMqjWXSQDgfM4v154qarLJrF1S
         eQGfyBTUYviRg8FY3WNzDgksbR4ULBQXgLmYRUJ9yE+wLrRJbyY9HE1G1qcAJWvRL9Zi
         r06w==
X-Gm-Message-State: AOJu0YyZPCTVSTHRgvUU8U3zbhqckwoE6pCbJMV6mXpdiWaoh2AAGtwH
	wSkOG7reHZpp+0f4vyIGBsDyKF+1QhiqcOWId0WSzHQ8gvx5R57lvu68PeO/kHs=
X-Google-Smtp-Source: AGHT+IECdYie+yB4Pf/vq/piS0C+Bk8MwDLpzUMS+SvmLgPCgutgal5hnjxz5Xdv/kpTE3jzx8VfNQ==
X-Received: by 2002:a05:6a21:3101:b0:1a0:9e64:f06f with SMTP id yz1-20020a056a21310100b001a09e64f06fmr4114361pzb.32.1708365983790;
        Mon, 19 Feb 2024 10:06:23 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id le6-20020a056a004fc600b006e40abb55c5sm3396607pfb.216.2024.02.19.10.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 10:06:23 -0800 (PST)
Date: Mon, 19 Feb 2024 10:06:21 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maks Mishin <maks.mishinfz@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] m_tunnel_key: Add check for result hex2mem()
Message-ID: <20240219100621.7bbb708e@hermes.local>
In-Reply-To: <20240218204026.7273-1-maks.mishinFZ@gmail.com>
References: <20240218204026.7273-1-maks.mishinFZ@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 18 Feb 2024 23:40:26 +0300
Maks Mishin <maks.mishinfz@gmail.com> wrote:

> Added check for hex2mem() result to report of error
> with incorrect args.
> 
> Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
> ---
>  tc/m_tunnel_key.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tc/m_tunnel_key.c b/tc/m_tunnel_key.c
> index ff699cc8..9bb5c2aa 100644
> --- a/tc/m_tunnel_key.c
> +++ b/tc/m_tunnel_key.c
> @@ -575,7 +575,10 @@ static void tunnel_key_print_geneve_options(struct rtattr *attr)
>  		data_len = RTA_PAYLOAD(tb[TCA_TUNNEL_KEY_ENC_OPT_GENEVE_DATA]);
>  		hexstring_n2a(RTA_DATA(tb[TCA_TUNNEL_KEY_ENC_OPT_GENEVE_DATA]),
>  			      data_len, data, sizeof(data));
> -		hex2mem(data, data_r, data_len);
> +
> +		if (hex2mem(data, data_r, data_len) < 0)
> +			invarg("labels mask must be a hex string\n", data);
> +

invarg() is intended only for use in command line args.
This is where the result of a geneve option from kernel netlink is being parsed.
Not user input.

Not sure why hex2mem is needed here at all? The original data is in the
netlink message. Doing the inverse is redundant.


