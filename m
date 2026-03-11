Return-Path: <netdev+bounces-266456-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJHoLDDrsGlwogIAu9opvQ
	(envelope-from <netdev+bounces-266456-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 05:10:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B41B625BD19
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 05:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CDAB5302606A
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 04:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CC830ACEE;
	Wed, 11 Mar 2026 04:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IUlCSaOY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBE619644B
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 04:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773202219; cv=pass; b=AqZM77Ae15AvZizEdRFjvTWipKreUQCoCpgixFagopPxxDJ4sw6NemMbcu/HUlxEPWRHuh7bWvczMSqzkHTMOn8NICL8xfsFq/JXyHalPu6bVOYKIThCQDBqCjy/mNh36iiztH+csFfBArn8o/sce8CUWCNGfI8YzxcbfEW3x6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773202219; c=relaxed/simple;
	bh=MBEHeJJqSEBgW4Nd1+NCcQSg5LShs4baZxRE586zPOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c/eEaMpKFB63D/oA2XQF+VmvYcM25YDk3/HyVs1tbooW3KFFvhS4L3Q2atfyt+WHvO9EpE7ayOkfEcUdLPKTegFHpxHc6SHfiJc/8TupjdkbmKYE9EeyxQ+FF2fLj6h4/h9AK6398+/xN9C2YQRi5+mCNe8HsRVPvsIyIG8shZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IUlCSaOY; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1271195d2a7so966851c88.0
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 21:10:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773202218; cv=none;
        d=google.com; s=arc-20240605;
        b=OWP3XzFVnrYMbr03ECpXY2ez4qe1EoMxIYmdU9yoJ/Jfvcv3NnCLADOyv3ajvNckMd
         0F0nAXYKhYIpidTW+fzljsBcV+zkPnfcloRKHG0snOnTHPEiyS298tahlfqmxMfNjwfF
         PMd7FBTEdBQgeWHvxpulGCW93JXYZtwbS5MwmXE3cbfDSC0QqL3xTPARrplEvPV/oo54
         5fHqKy5qhjKpputd0A07iWPb6aKnWawOW81Ls0/tHqzh7Jw7ZS49wlo4aLC1V4oMPSKi
         oMhDPFqPBKzjShrWMpGS6L02MWCHOI06VYj7bih0hFP6Z0LmmUkqd8AVOz61ZBPpaoKg
         pRBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MBEHeJJqSEBgW4Nd1+NCcQSg5LShs4baZxRE586zPOM=;
        fh=YU4b7ArziLCXexp2oOBB23Uu7sxFK70ehy4wSwWkit8=;
        b=bp96sHUQMLdINKSHgca9i+aSxuusPKLN34kpPQ/u+jIRTDzf5Ryq2yP1WwOl2KYIEs
         ry1lZhILMc+WWJVULNlbToKEWKOkOFN2vuSK750RS5Bw7ta1aCYrlzaZBEMUbdt95iOP
         x/Nbt94BZg/PB+c3mNL7VvnVitTzG9oIXoKxiQhhlvr7ZFzdE7B+/PuDCufnXPfPNlBy
         JLCAKuIOd3MkIBVerCnw/0Bz1sP3+lA3qrVwiJOGcdoHpzJ7p6XZuCouSpjyqideX0lP
         n+9IkaodczGorGgXkj5ifL6Z66/G7zlznSN4ED/Hnnhrr3Hk74zoVm/72lI0oDtMdH7u
         WViQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773202218; x=1773807018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBEHeJJqSEBgW4Nd1+NCcQSg5LShs4baZxRE586zPOM=;
        b=IUlCSaOYcDYoSvYKTPlStN2t5DPJi4OYzPrBd7EQtLELTsckelsLUKoBmVLg576/kS
         CKwK2yIwIpfkN2LaHN7w5K8PfKyItbIgfKGLGHLo7wBPdfOJGTgHTqvsqzF36fT028I8
         YCc5I0z9K6tJhsM099yGsoQ0Xz/OuFLY6AQEGKdhX+gUZUpe7TRcp/sOnb2N87tVo0dv
         /5gzpFdb4rPfN4oCJJ8tbFvhQlWFp34vtOx3KOnZBkZFcR6iKJAQGRfhmc/os2w28yNj
         5EnLVmNzDwxE5RwtyQwE36zILmH4/npNDg1aYq1ZloWlYOS3Qe0cLM+8FVw7WqEkhpOW
         9cCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773202218; x=1773807018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MBEHeJJqSEBgW4Nd1+NCcQSg5LShs4baZxRE586zPOM=;
        b=lMdEFf7uRSzOd+w487/qSPxjFhu+qwCGT7kCDp37rwZeQZuJ795rAdb6fdSw1jlrPq
         AedLW+trAgNYwjq/qJrbnYWY3Taw9t66NPVVGx8yiozhol86lEoMOg4LYBK8XC773231
         vbTOOYvVl2DWG46uOwEmgXMBJOymJmckpQREwGKC9K/5F6o8y4i7JxEgYANswBpdbsl9
         MvuRtGzCmSl4W3ghpjpj8yDhXJoxZJUZFFNQ+0vyOiCSKuKxS9uiJqXe3uRY71dCVWd+
         f80gnkSlzceV2jESfJSgccJtr683xlP1zfu1tovgGg65zi3Htn9HdcmC5ado/zqprTIQ
         r5jA==
X-Gm-Message-State: AOJu0YxsuA35do9j0sad3wqcs0hnajz9Ucaxp04mBNTOjU7T9Gd0wHzc
	4V70tvPCXvQ5WdR4P0+y+ct0tSLikIsmoNU5EB/euwP1X607dblCKbq9kGzFQEdGI7NxVL7SktL
	G/o1X4iI7uoCQWoEYYVQn2zax6xF3rz38Z44PcJQc
X-Gm-Gg: ATEYQzzRJgXPCDwVt60jK4IUwrpH6+OVA9kv/I/FYuNVPd+RnQK6OZJ9fCkqDUaBs3f
	yzRIi5vF/z5ncsxA3ezWxsXKIGT43oVapD0NujMX4zcbATOud0BEL4vWh6pm+6kezWqyCqgYElS
	i5iGMH4dYW3LQlunEzB9+77Rp9C7PWBErfdx5yfGspJt0RvO90DLJ6zsRNLC3HCf9e1ckvoxZ17
	7OHK4D1FPfFa09eKnMjQ2C5+9L23tSg8kqE3jTey/Uv0a9G/WSn+VQe8UGwI062ru0vo1X/4xG9
	6BJf8O3/vii4UzKcqtVlI8CgqycPCyTmcg5nDSz5vnWwskwQpdoenWgTcC1cIrxB/7bN97w=
X-Received: by 2002:a05:7022:fa3:b0:11b:f056:a19b with SMTP id
 a92af1059eb24-128e77af41emr591178c88.18.1773202217272; Tue, 10 Mar 2026
 21:10:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1772894876.git.sd@queasysnail.net> <d28f72b5b4ff4c9ecbbbde06146a938dcc4c264a.1772894876.git.sd@queasysnail.net>
In-Reply-To: <d28f72b5b4ff4c9ecbbbde06146a938dcc4c264a.1772894876.git.sd@queasysnail.net>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 10 Mar 2026 21:10:06 -0700
X-Gm-Features: AaiRm53pv_QQgxejGOlkcf490qHoypqLXDfrkM6zmrqE_kvKIqB5u7SSItGllIs
Message-ID: <CAAVpQUCF2bLS98J5HHg4VVPMpuYm-TncZfFfQ8m-D_1mLRpxkw@mail.gmail.com>
Subject: Re: [PATCH net 2/2] selftests: rtnetlink: add neighbour update test
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org, David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B41B625BD19
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266456-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[queasysnail.net:email,mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 2:59=E2=80=AFPM Sabrina Dubroca <sd@queasysnail.net=
> wrote:
>
> Check that protocol and flags are updated correctly for
> neighbour and pneigh entries.
>
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

