Return-Path: <netdev+bounces-128813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9580697BC98
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 14:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BF9A1F218A1
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 12:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB0E17C9A7;
	Wed, 18 Sep 2024 12:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0RcPAlBQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285034409
	for <netdev@vger.kernel.org>; Wed, 18 Sep 2024 12:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726664071; cv=none; b=SQHQPFypqJIoH+ib1SaX8aFgZbupTRuBujAreySv8y68abIB6/GImOhFk3M7vq21q45bas6RR/aFkoDLK1HA2PvCiYDNIX21E1ZO0WbY9Yvr4t6xhJQ3WzR3Q7xDsuN9tJF8Vrxj0IPrHCoUrxjQNORI/c32T1quAEf0gU1q6B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726664071; c=relaxed/simple;
	bh=ef3HrEgDtu4ft+ZmlgTfdbkDsLyBnVrav+g26MJalvk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D2r9u9vfYInG/1TRVpI1+20oATskWlIaNgY7O1FWa7ZXe7+KzNGoIWpQAJ6FE6zOVsyzlq/Cx1ekmXxEtGX/JE4GCl8d6w/dWth2TdohJgIG6ZLiEfqSo8s2MTAwRbtqslZSgDJjK+lZ6NcC/SyfAtJ4tT01u/IwJBAPKUzpWwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0RcPAlBQ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e17bb508bb9so10947428276.2
        for <netdev@vger.kernel.org>; Wed, 18 Sep 2024 05:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726664067; x=1727268867; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YTRc08FCczPdsW71H9JOH0y/m0GfJajHcBYzYYeDq6A=;
        b=0RcPAlBQ5LXPemWWpnsKJ/2PvyCL8G8+RQNwROoPvWDHMMvh54DHljCJwB5W2sABZC
         ui9r6H6zs1U29tumUmtvFtCrN0VHeoirUJNzOrQePQc1nnH0+NK0VeOQ+WvN9Wnort6S
         aw3zhloTf+qfhpeE3xSdHtfkJIrsJQEp5mwOCt1pgLdhqcxZS6dz0btU514zx/kBz6rZ
         RF4hFdKWZ23E7tQ6oOONFIt4fonASdPgorj1+5Yuq7C40FBJkTJ4B08siROHAnoP5LXm
         UePNQgi2QiBJ4k137bfPyrRNP2TEXxBeusUsj36KRzloDv0nrS9zXgEN71RYETjlJqdK
         gjeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726664067; x=1727268867;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YTRc08FCczPdsW71H9JOH0y/m0GfJajHcBYzYYeDq6A=;
        b=bIt3vH+AzhCsarx/oZIJS9x7ZXlq6qAnsROoQCDUC+el/En7aBh+sNCOEyjN/a3zB5
         RD+LZONjghEm0HX7dp8NCBUOWiU7X/84AMEEm7+5/kTzVdUWqc2H10w22bMjVi1vwd6k
         pJybUl6+CrvcSupTg+MKoGiNQ3z96zfRcLR5ptpWL+YeypptRlQ+EtXhNm+3VIasLGSl
         Zp+epy6RikVfpKTQTGbK3jtg3Pzk0RVcC9Y1/7YvL2075uS5qhkugRtHC1M4Hko3GkrJ
         xPxzdpiceSdlFw1uJX4lCaU2lae3e8UlObweL0K6o9aNSC/eotL1GJrycknlSmiOn9z7
         Ec/g==
X-Forwarded-Encrypted: i=1; AJvYcCX4nCL6NK1RY9HyaF6mr96ws6n2C5oI7bgW3r/mUsMepDsNQKwIes+1aphGsWNs8HTwd4gQQL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxayREi0UwrmoMMzA+p9WkLSUJmOaFTjr/TzqRaUCJBX7YLqxr7
	7NtAWybV7ctVBbIpb0PgtNnAWXsdEqEOZz9O+c/kOeOJygOJQAdJNdyLIry/8YeumuztIJqljdd
	y2Q==
X-Google-Smtp-Source: AGHT+IG15o1jupjyYUDnAEDGWyZO2IZfc9aAQm42wZdtbhtjP347i/eQgmQspm1GEYKrYUVWJmrn23hrnl0=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a25:d344:0:b0:dfb:1c1c:abf9 with SMTP id
 3f1490d57ef6-e1daff59debmr60712276.2.1726664067072; Wed, 18 Sep 2024 05:54:27
 -0700 (PDT)
Date: Wed, 18 Sep 2024 14:54:24 +0200
In-Reply-To: <20240904104824.1844082-12-ivanov.mikhail1@huawei-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240904104824.1844082-1-ivanov.mikhail1@huawei-partners.com> <20240904104824.1844082-12-ivanov.mikhail1@huawei-partners.com>
Message-ID: <ZurNgJKzG-oWL3Tq@google.com>
Subject: Re: [RFC PATCH v3 11/19] selftests/landlock: Test unsupported
 protocol restriction
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: mic@digikod.net, willemdebruijn.kernel@gmail.com, gnoack3000@gmail.com, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, yusongping@huawei.com, 
	artem.kuzin@huawei.com, konstantin.meskhidze@huawei.com
Content-Type: text/plain; charset="utf-8"

On Wed, Sep 04, 2024 at 06:48:16PM +0800, Mikhail Ivanov wrote:
> Add test validating that Landlock doesn't wrongfully
> return EACCES for unsupported address family and protocol.
> 
> Signed-off-by: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
> ---
> Changes since v1:
> * Adds socket(2) error code check when ruleset is not established.
> * Tests unsupported family for error code consistency.
> * Renames test to `unsupported_af_and_prot`.
> * Refactors commit title and message.
> * Minor fixes.
> ---
>  .../testing/selftests/landlock/socket_test.c  | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/tools/testing/selftests/landlock/socket_test.c b/tools/testing/selftests/landlock/socket_test.c
> index 047603abc5a7..ff5ace711697 100644
> --- a/tools/testing/selftests/landlock/socket_test.c
> +++ b/tools/testing/selftests/landlock/socket_test.c
> @@ -581,4 +581,51 @@ TEST_F(prot_outside_range, add_rule)
>  	ASSERT_EQ(0, close(ruleset_fd));
>  }
>  
> +TEST(unsupported_af_and_prot)

Nit: If I am reading this test correctly, the point is to make sure that for
unsuported (EAFNOSUPPORT and ESOCKTNOSUPPORT) combinations of "family" and
"type", socket(2) returns the same error code, independent of whether that
combination is restricted with Landlock or not.  Maybe we could make it more
clear from the test name or a brief docstring that this is about error code
compatibility when calling socket() under from within a Landlock domain?

> +{
> +	const struct landlock_ruleset_attr ruleset_attr = {
> +		.handled_access_socket = LANDLOCK_ACCESS_SOCKET_CREATE,
> +	};
> +	struct landlock_socket_attr socket_af_unsupported = {
> +		.allowed_access = LANDLOCK_ACCESS_SOCKET_CREATE,
> +		.family = AF_UNSPEC,
> +		.type = SOCK_STREAM,
> +	};
> +	struct landlock_socket_attr socket_prot_unsupported = {
                                           ^^^^
Here and in the test name: Should this say "type" instead of "prot"?
It seems that the part that is unsupported here is the socket(2) "type"
argument, not the "protocol" argument?

> +		.allowed_access = LANDLOCK_ACCESS_SOCKET_CREATE,
> +		.family = AF_UNIX,
> +		.type = SOCK_PACKET,
> +	};
> +	int ruleset_fd;
> +
> +	/* Tries to create a socket when ruleset is not established. */
> +	ASSERT_EQ(EAFNOSUPPORT, test_socket(AF_UNSPEC, SOCK_STREAM, 0));
> +	ASSERT_EQ(ESOCKTNOSUPPORT, test_socket(AF_UNIX, SOCK_PACKET, 0));
> +
> +	ruleset_fd =
> +		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
> +	ASSERT_LE(0, ruleset_fd);
> +
> +	EXPECT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_SOCKET,
> +				       &socket_af_unsupported, 0));
> +	EXPECT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_SOCKET,
> +				       &socket_prot_unsupported, 0));
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	ASSERT_EQ(0, close(ruleset_fd));
> +
> +	/* Tries to create a socket when protocols are allowed. */
> +	EXPECT_EQ(EAFNOSUPPORT, test_socket(AF_UNSPEC, SOCK_STREAM, 0));
> +	EXPECT_EQ(ESOCKTNOSUPPORT, test_socket(AF_UNIX, SOCK_PACKET, 0));
> +
> +	ruleset_fd =
> +		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
> +	ASSERT_LE(0, ruleset_fd);
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	ASSERT_EQ(0, close(ruleset_fd));
> +
> +	/* Tries to create a socket when protocols are restricted. */
> +	EXPECT_EQ(EAFNOSUPPORT, test_socket(AF_UNSPEC, SOCK_STREAM, 0));
> +	EXPECT_EQ(ESOCKTNOSUPPORT, test_socket(AF_UNIX, SOCK_PACKET, 0));
> +}
> +
>  TEST_HARNESS_MAIN
> -- 
> 2.34.1
> 

