Return-Path: <netdev+bounces-65700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3616B83B658
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 02:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5CF31F23E6E
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 01:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AC180A;
	Thu, 25 Jan 2024 01:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="wGk1cQw4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AF0612B
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 01:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706144661; cv=none; b=fbfLAFI4VVQ2pK/nHWvsUhLW9duC3Crb+tpDktwI9MdQOdrWAxUHxW3Ksq5fJtLBlrvTDKxcDEdvheTIBRmeHBD0W6qZ2kKJ9DV3qGpK7IXAQ3+vjPzgytNm/RCAOrvQn74aGxRWz9szxwrOaR9O5cxjw3r2MZ0lpkJE1QDxcPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706144661; c=relaxed/simple;
	bh=EZzpsgePo+djzbSpl5JFSQFRBuc8XUzlCMjWIz4kJKA=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=SMcuYOS6Lc/XYkiqSxxKvbtyRiIXYMLnt7Ce86HeVpa2GZpwEarM5ik6s2NURjgskwipRUTIwo+5YTH1jNF+b7GDHWKduEBsQZku8ghFFCIi7ps5s/i1cEU/GcwrV8RZeLZRESGX5EaFy7jqDr2joouKqot8q7t3DLUGktwoVEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=wGk1cQw4; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 58D0B40A1A
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 01:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1706144655;
	bh=6nGE4+6Tx026DBgNDy4Vl1932vS7jfNlCk2XeKLwqLg=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=wGk1cQw40RiKjmKjiGEcNkQvWXGGKnlfsYKl7vDB+I11OgQIWoY3r2fd1XlGKADj1
	 IdoVKaS0z2JgSTS/wxVFXUl7BuAS+FCQ3I8HQu4eo+2FfbM1xGEczhykm2WM08Asnr
	 U01Q/HLcs2eAXGEBhpTtjjwDUbpCdqDhkTJCW662/Tz4SEsw3YPdzK+PEd9MjVSEQO
	 hDbwA9R6rI+oNVwb0WoXb+cfmy8kXe+MIQEOeI7KRYEtBuRSV4Vc17N4UTXr1eWOvr
	 fO0bcXbnlrxNfFI2KlhdemURIOYewYgH8+qiebhfmhSFiOruds7VBqqBL3eUUeY1qV
	 OzB4fySa8tRGg==
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6ddc1b3042eso973878b3a.0
        for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 17:04:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706144653; x=1706749453;
        h=message-id:date:content-transfer-encoding:content-id:mime-version
         :comments:references:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6nGE4+6Tx026DBgNDy4Vl1932vS7jfNlCk2XeKLwqLg=;
        b=VLqrPgZAqnfZ7kyqYbfxpiPWAR4AYQQpZ1tPtiMJLE1hSPdr5EPFUM7rvf5tqkzq1t
         lZCLL3+P+7eA8YKqeRMW1vmqdpIsris6L1hbV0a0gXKWYpHzquvWmRWOZe1OdzI2aFQL
         hrFAJX5qYwOLYjBzW0TPzhhfA+fMJfV3INw1FuDyJyr11/HMWrMGLCz83HYtrTZPBh7z
         +JS1KyyZaBWoputLwbHXBio0N5PSELVy3HY2y2dH8wPgZxKyZna18gSbn1I8yGaoSWYB
         ZmmM9rX10zjErOzj8KOO4lEN6pLCyq/0//7hTNp9yQlZdUzHvccxjhmQussKh8fng4AG
         LCbA==
X-Gm-Message-State: AOJu0YyLIeLPGtikzpgUYd+qJ6MLDcWcNhFQp5Yz/hnz+Hemv5BKyKXn
	R3zbL1H6uLjmbeHPlFSzhvqJ0z1rhOyDQ+0ZykGWaY7Ctiwe2QPNWtcRxlWkyrJ2U24TTVxi1Z+
	5Gs76BAQjsTPKKFdmW+7aCYqp9E7RriXE/1QghZdUDAgW7ccxF3sVFfDk1pEXDtaBkDTUJA==
X-Received: by 2002:a05:6a00:3ccc:b0:6d9:bc39:e5ac with SMTP id ln12-20020a056a003ccc00b006d9bc39e5acmr75823pfb.6.1706144653310;
        Wed, 24 Jan 2024 17:04:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGW9Z2MhioudRS+SKSTvaNyKM/YOhFpiKFRJbhEmnNjJ5jynf+ezCCRry3tAJ2NTS45Lo9f3w==
X-Received: by 2002:a05:6a00:3ccc:b0:6d9:bc39:e5ac with SMTP id ln12-20020a056a003ccc00b006d9bc39e5acmr75800pfb.6.1706144653035;
        Wed, 24 Jan 2024 17:04:13 -0800 (PST)
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id c4-20020a056a00008400b006dabe67bb85sm14391192pfj.216.2024.01.24.17.04.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jan 2024 17:04:12 -0800 (PST)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 410EE5FFF6; Wed, 24 Jan 2024 17:04:12 -0800 (PST)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 39C219FB50;
	Wed, 24 Jan 2024 17:04:12 -0800 (PST)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: Benjamin Poirier <bpoirier@nvidia.com>
cc: netdev@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
    Jonathan Corbet <corbet@lwn.net>,
    Andy Gospodarek <andy@greyhouse.net>, Andrew Lunn <andrew@lunn.ch>,
    Florian Fainelli <f.fainelli@gmail.com>,
    Vladimir Oltean <olteanv@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Petr Machata <petrm@nvidia.com>,
    Danielle Ratson <danieller@nvidia.com>,
    Nikolay Aleksandrov <razor@blackwall.org>,
    Ido Schimmel <idosch@nvidia.com>,
    Johannes Nixdorf <jnixdorf-oss@avm.de>,
    Davide Caratti <dcaratti@redhat.com>,
    Tobias Waldekranz <tobias@waldekranz.com>,
    Zahari Doychev <zdoychev@maxlinear.com>,
    Hangbin Liu <liuhangbin@gmail.com>, linux-kselftest@vger.kernel.org,
    linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next 2/6] selftests: bonding: Add net/forwarding/lib.sh to TEST_INCLUDES
In-reply-to: <ZbFkhmEHBSHgJ4d1@d3>
References: <20240124170222.261664-1-bpoirier@nvidia.com> <20240124170222.261664-3-bpoirier@nvidia.com> <8205.1706120677@famine> <ZbFkhmEHBSHgJ4d1@d3>
Comments: In-reply-to Benjamin Poirier <bpoirier@nvidia.com>
   message dated "Wed, 24 Jan 2024 14:27:02 -0500."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <28468.1706144652.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jan 2024 17:04:12 -0800
Message-ID: <28469.1706144652@famine>

Benjamin Poirier <bpoirier@nvidia.com> wrote:

>On 2024-01-24 10:24 -0800, Jay Vosburgh wrote:
>[...]
>> >diff --git a/tools/testing/selftests/drivers/net/bonding/bond_topo_2d1=
c.sh b/tools/testing/selftests/drivers/net/bonding/bond_topo_2d1c.sh
>> >index a509ef949dcf..0eb7edfb584c 100644
>> >--- a/tools/testing/selftests/drivers/net/bonding/bond_topo_2d1c.sh
>> >+++ b/tools/testing/selftests/drivers/net/bonding/bond_topo_2d1c.sh
>> >@@ -28,7 +28,7 @@
>> > REQUIRE_MZ=3Dno
>> > NUM_NETIFS=3D0
>> > lib_dir=3D$(dirname "$0")
>> >-source ${lib_dir}/net_forwarding_lib.sh
>> >+source "$lib_dir"/../../../net/forwarding/lib.sh
>> =

>> 	Is there a way to pass TEST_INCLUDES via the environment or as a
>> parameter, so that it's not necessary to hard code the path name here
>> and in the similar cases below?
>
>It think would be possible but I see two issues:
>
>1) Tests can be run in a myriad ways. Some of them (`make run_tests`,
>`run_kselftest.sh`) use runner.sh which would be the place to set
>environment variables for a test. However it's also possible to run
>tests directly:
>
>tools/testing/selftests/drivers/net/bonding# ./dev_addr_lists.sh
>
>In that case, there's nothing to automatically set an environment
>variable for the test.
>
>I think that could be addressed, for example by putting the content of
>TEST_INCLUDES in a file and having the test read it itself, but ...
>
>2)
>As can be seen in the dsa case and in the bonding and team cases after
>patch 6, the relationship between the files listed in TEST_INCLUDES and
>the files sourced in a test is not 1:1. So automatically sourcing all
>files listed in TEST_INCLUDES is not generally applicable.
>
>Given these two points, I'm inclined to stick with the current approach.
>What do you think?

	That rationale sounds fine; I was wondering if there was a
straightforward way to centralize the naming of the "library" without
having to literally hard code it all over the place, but that doesn't
seem to be the case.  Thanks for the explanation.

	-J

---
	-Jay Vosburgh, jay.vosburgh@canonical.com

