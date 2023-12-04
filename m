Return-Path: <netdev+bounces-53554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D94E803AB3
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 17:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E1371C20B75
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 16:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E24F28694;
	Mon,  4 Dec 2023 16:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Plp+3Crx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454B7D5;
	Mon,  4 Dec 2023 08:47:17 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3335397607dso468220f8f.1;
        Mon, 04 Dec 2023 08:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701708436; x=1702313236; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hZbhxENWu8ykG01137JiGDS2ikH3pLTwTF31Z+cfLyY=;
        b=Plp+3Crx3oJhmSzcJZHuKXqNL2zkXOi0yWrB/8aNdvwFUqNvSua143y9s8BBIl6PHW
         zD7Z3JGbdDr8ij6YR/9F/fUDStVDNvSIZIN/4wweVTpxpo77hdp0tz8G6oqA8Ae/9lJo
         FtuoeHXWYlK+7F0+q7z3mZbWSEJGrAOWy2USH1DghaJDiGVAJpv5mLv/nVZNYxXELQFL
         UunVQzyNg7fHCmVULkVG1ShLdmz8Y4XfZP8K08PZOdrIMeHaTgslK57ZTkfGddYbHQgI
         FeymPmlTpYwZ4B8lbusTxnGtdI9Q5e/flBRqPO6KorTD4+zW2XYju6GpgjJJHlLqatty
         YyOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701708436; x=1702313236;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZbhxENWu8ykG01137JiGDS2ikH3pLTwTF31Z+cfLyY=;
        b=LHzYzONXmRKz7mS8yBKP15Tg41J+x2w4ti4NdL2jolPt6gz7Ai7wp694V2DQv3CGa6
         rLpXA+89iPjsKtOM/U85Sh3iPMcayl6dIQf9YEmDjlgMImJqR1PdQCJXhkLfs3pAsXXJ
         9uzsOd/5Pd00QNp4rbZi80qeXgBn6SlglUtsXcUUvijp5uG97TLcsRPAZsMga0VUC+9G
         RL4WUHqHLX2p6+aKnM7Lu05EK17ul1GIVRTyJQRLrjpEJSLZ3YgnFjOFgp84fP1YcEfB
         JYO/6Z98l2DfpkK3p7TAUWI9E4CR/bVXwHAZenppbPgjzx0CJB3pBFBxOwNrNF/vZVXd
         u1+Q==
X-Gm-Message-State: AOJu0YzWw0Sp3Kg9cGBPwTgtCScT3qYJf1yepZEtsr6ErUwAhKUHEwx4
	kdLmKLOi5rhu4ZAhVuuB58NLF5lkYJuwww==
X-Google-Smtp-Source: AGHT+IEfMzk27h7MjKRFSXgKfCtWkTXT5bTNzp2w/jpFUwGJp1Btpu0JdH4/B+d4fHkQYS2Hfgsu4w==
X-Received: by 2002:a05:6000:10ce:b0:333:2fd2:2ed8 with SMTP id b14-20020a05600010ce00b003332fd22ed8mr3768600wrx.81.1701708435517;
        Mon, 04 Dec 2023 08:47:15 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:d9c9:f651:32f4:3bc])
        by smtp.gmail.com with ESMTPSA id x18-20020adfffd2000000b00332fd9b2b52sm6711870wrs.104.2023.12.04.08.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 08:47:15 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Jonathan
 Corbet <corbet@lwn.net>,  linux-doc@vger.kernel.org,  Jacob Keller
 <jacob.e.keller@intel.com>,  donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 2/6] doc/netlink: Add sub-message support to
 netlink-raw
In-Reply-To: <20231201175314.26cfcefa@kernel.org> (Jakub Kicinski's message of
	"Fri, 1 Dec 2023 17:53:14 -0800")
Date: Mon, 04 Dec 2023 15:58:09 +0000
Message-ID: <m2h6ky6ju6.fsf@gmail.com>
References: <20231130214959.27377-1-donald.hunter@gmail.com>
	<20231130214959.27377-3-donald.hunter@gmail.com>
	<20231201175314.26cfcefa@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:
>
> SGTM, could you add all the info from the commit message somewhere 
> in the documentation? Perhaps a new section at the end of
> Documentation/userspace-api/netlink/specs.rst

Ack, will do.

>> @@ -261,6 +262,17 @@ properties:
>>                  description: Name of the struct type used for the attribute.
>>                  type: string
>>                # End genetlink-legacy
>> +              # Start netlink-raw
>> +              sub-message:
>> +                description:
>> +                  Name of the sub-message definition to use for the attribute.
>> +                type: string
>> +              selector:
>> +                description:
>> +                  Name of the attribute to use for dynamic selection of sub-message
>> +                  format specifier.
>> +                type: string
>
> We can leave it for later either way, but have you seen any selectors
> which would key on an integer, rather than a string?

From what I have seen, I am fairly sure it's always going to be a
string. (famous last words)

