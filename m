Return-Path: <netdev+bounces-46832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C19BC7E697C
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 12:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 613C7B20BEF
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 11:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EAD1A5AB;
	Thu,  9 Nov 2023 11:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hg5vkPuI"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57342199D5;
	Thu,  9 Nov 2023 11:25:13 +0000 (UTC)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EB62D64;
	Thu,  9 Nov 2023 03:25:12 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5bf5d6eaf60so5529667b3.2;
        Thu, 09 Nov 2023 03:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699529112; x=1700133912; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/0HXfz/RYRjdCn8R6IffJ7Qc4ROY093vNOoEeYEQ5SY=;
        b=hg5vkPuIoWuP1HQKsde16/KZFBFDCrDUA1wA0fI/Gg61GYn7uPArlxCm7+t6cXQvWA
         jyodCm/iSR68FT0yJnkBXBIuMG28J9E1eZWvFrTEiuqwPjrig9HYAh2pOhoAOtgJbpm0
         wZayujbbvHR66lllaBhaLVTSd1iStw2/v8ycgnAwIjjTY86uc8tp1ogU8Ea3pgvzI8tC
         QX7b/IToXkcDAwo3piWODEaJHXd9o1CzXNZAHLY5Cc1gVdcO50JWVUqgOMmBrmYt2j5o
         ji0siRf//OhN3WDxsASg6x54V6RolJv68RggZp+JpZp+DELphdWAKUduUjZcsDZE294T
         xLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699529112; x=1700133912;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0HXfz/RYRjdCn8R6IffJ7Qc4ROY093vNOoEeYEQ5SY=;
        b=WgrJ+Msrdsw133sEGGtma21utJ+LuNFzd3IdlS5z4Jy/9p1wa+OaMpD16Wf+30561v
         n+Uzf2DjchpPmDRaLqfpXdkK4GE1/1y2tgDykOJk76TXy7kfLB8JsW5/32Pcy2MZiM7I
         eYDBaGcN4lyCb0GJMdJH5asP4dbUCgXT28AlJHeslhreS4I2pCPN62pvi9CauGIHengm
         6CMHaU3OTbLUCRfCnbfSkO1Tya0GPuo4wOcVH73VpD7rq4kCfJnD+6ktc/N7KLl5E0EI
         ymziPVPCqmnEBTptODNxbiwgJtBFDq7elTPWkjj32/4D7kctvpKB8CQ/07O/qmtgTZrz
         jsWQ==
X-Gm-Message-State: AOJu0Yzb3lUrQszh3qt5ysq/BY6hfuvl8KeimW5LL+UQX/dg4RSU6yA/
	mDyAPjGandUD5yVizO5Rn9B5ENqsXhofS2F2
X-Google-Smtp-Source: AGHT+IFg4fbgIkMn4hbtwKeaycyyfpogNFQgIp2PbG64oNmhXwEi9viSqmyOnpgf+OdU8NxxfFX5jw==
X-Received: by 2002:a0d:dd0c:0:b0:586:a684:e7ba with SMTP id g12-20020a0ddd0c000000b00586a684e7bamr4865149ywe.39.1699529111754;
        Thu, 09 Nov 2023 03:25:11 -0800 (PST)
Received: from imac ([88.97.103.74])
        by smtp.gmail.com with ESMTPSA id mh21-20020a056214565500b00641899958efsm1982340qvb.130.2023.11.09.03.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 03:25:11 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Breno Leitao <leitao@debian.org>,  linux-doc@vger.kernel.org,
  netdev@vger.kernel.org,  kuba@kernel.org,  pabeni@redhat.com,
  edumazet@google.com
Subject: Re: [PATCH] Documentation: Document the Netlink spec
In-Reply-To: <875y2cxa6n.fsf@meer.lwn.net> (Jonathan Corbet's message of "Wed,
	08 Nov 2023 13:27:28 -0700")
Date: Thu, 09 Nov 2023 11:22:05 +0000
Message-ID: <m2h6lvmasi.fsf@gmail.com>
References: <20231103135622.250314-1-leitao@debian.org>
	<875y2cxa6n.fsf@meer.lwn.net>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Corbet <corbet@lwn.net> writes:

> Breno Leitao <leitao@debian.org> writes:
>
>> This is a Sphinx extension that parses the Netlink YAML spec files
>> (Documentation/netlink/specs/), and generates a rst file to be
>> displayed into Documentation pages.
>>
>> Create a new Documentation/networking/netlink_spec page, and a sub-page
>> for each Netlink spec that needs to be documented, such as ethtool,
>> devlink, netdev, etc.
>>
>> Create a Sphinx directive extension that reads the YAML spec
>> (located under Documentation/netlink/specs), parses it and returns a RST
>> string that is inserted where the Sphinx directive was called.
>
> So I finally had a chance to look a bit at this; I have a few
> impressions.
>
> First of all, if you put something silly into one of the YAML files, it
> kills the whole docs build, which is ... not desirable:
>
>> Exception occurred:
>>   File "/usr/lib64/python3.11/site-packages/yaml/scanner.py", line 577, in fetch_value
>>     raise ScannerError(None, None,
>> yaml.scanner.ScannerError: mapping values are not allowed here
>>   in "/stuff/k/git/kernel/Documentation/netlink/specs/ovs_datapath.yaml", line 14, column 9
>> 
>
> That error needs to be caught and handled in some more graceful way.
>
> I do have to wonder, though, whether a sphinx extension is the right way
> to solve this problem.  You're essentially implementing a filter that
> turns one YAML file into one RST file; might it be better to keep that
> outside of sphinx as a standalone script, invoked by the Makefile?
>
> Note that I'm asking because I wonder, I'm not saying I would block an
> extension-based implementation.

+1 to this. The .rst generation can then be easily tested independently
of the doc build and the stub files could be avoided.

Just a note that last year you offered the opposite guidance:

https://lore.kernel.org/linux-doc/87tu4zsfse.fsf@meer.lwn.net/

If the preference now is for standalone scripts invoked by the Makefile
then this previous patch might be useful:

https://lore.kernel.org/linux-doc/20220922115257.99815-2-donald.hunter@gmail.com/

It would be good to document the preferred approach to this kind of doc
extension and I'd be happy to contribute an 'Extensions' section for
contributing.rst in the doc-guide.

> Thanks,
>
> jon

