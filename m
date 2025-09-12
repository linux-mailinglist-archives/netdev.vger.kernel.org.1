Return-Path: <netdev+bounces-222560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F15F1B54D47
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 14:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9988C17F13D
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 12:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5A33093CB;
	Fri, 12 Sep 2025 12:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/oSd1W4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927EB32145E
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 12:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678931; cv=none; b=Wk51odk12OyntxHSUT8BZZdjCKm2YIVApzzMWvTXcj9kX8H3HEexKVpPpEUn3kmEgB/LfXWDfhtyoYs7m8DIIpHGIlXslldtAJFAEuixDI2F2z4LYFIi+VCQTua6/ggsiNCdGGh6tYdsvrz7gDwVlj+HCMcJNqYCCTzBq+lZmMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678931; c=relaxed/simple;
	bh=pg2OzxfdDmvV4PZ3/yrEF/ttLXM7KmEXR3GgYwf88oM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=fa6lrTMcNST2nhKswP37dlYXbu1oWfiilOoxq5zyORyO56nR//JihUlXJyo7jDU4BcxbckfnVxrD6bNAIvbDJM1fKrA0/3cWQC8oY/ywyB3pAi2Uzd+NcA/4DAzfRxP9DU4b4rgZFHRhlqCoQGx37rr+InPBp5+3uwHWmhK7Zi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/oSd1W4; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45df09c7128so14938255e9.1
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 05:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757678928; x=1758283728; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z3mBB6R4Rvgptsn0OxjqAYg70NanrEyHXxP0kqh9yyw=;
        b=j/oSd1W49q5GqUpc4lcLYvy2FpJ6r6ZYirBlz6SCqXtj+q1E4NhrYMAZRt2jCALf3Z
         aYdOqFTvZZ7W3ga1P0A4UJ4iPdackJG2xm3HJTeoqJnVJ3+xXSFFYLDYJ6rBlWxTyIvS
         u8CIOf11nkX+DDYBU9a4/FJ7TDYPDJTJ3d5Pjn4MOJcDzWSBjvjp/59HyOerZOkzWRrz
         P3Yl115aDgI4ZVtknoMN6rAtqJ9Uh9w+3qjzQK3X0WdDAvFPmDmhCLcS/QoXXqXtzi5q
         EgzhFN7HpA1/iV+GgMS10JQNKzIiXB64Iukc582CTVveKrg/kBbBhvImGFf9zN8MN/JP
         z0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757678928; x=1758283728;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3mBB6R4Rvgptsn0OxjqAYg70NanrEyHXxP0kqh9yyw=;
        b=mNGgsY6d6DJFJ3rBKxrHK6+IRJH8RUq0xJHjEObbFg4vQx/WnIL+Nuan7ItSWrsOMK
         8AItIKb0qOcmTR+sjoXQXWm/MecHpxMRacC+eTYvZsxHx/Zl+qeoFCPRj340bAYwWl1H
         HGu6n2vOAhNtYXjoEMWkFeJ0B6pZfwHD0fXlDuZ5xBPcCz5vhF/WitO/YrTiUhxv0B4p
         1hVExsfuhZkeKpuuQ5aKAOaXhHA6X2mS8O69/WT0ushq2xkXF7T7OgDes3OW9vinWi5H
         UVYYTPf52mnCarhIHYmMe6z/o+uS0PKzGAMZl4ylqy2R4d2IZVf4wzrxWH3wodui0HW9
         N2IA==
X-Forwarded-Encrypted: i=1; AJvYcCWKl3mBHpXvfhcG0XyzVKlB8ME8+D7Y3tzan/jfkuCPiCY2DXTNlmQXJnhCJ6BqhonE1KKqVmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVf+bezVZ3o5kx6uRr9CXZi3tyY/cL6mEZRr2/bZn5eqSlthPl
	vcGeh33ANIo8s1LFyS3oZz/pHxzJoFNuT6RNtm/OK4qIXqoiskJwNAAJ
X-Gm-Gg: ASbGncv45oL99PohJqecObV+ebc1wWHUhSZIfNezQq/v+KJeVwR6gvYGBTCFEPZAR1S
	zPKeFSO3sUbIzwEEC0zhtoB1EJjebcavLilF8NOVfA3Rem/bzv2j+dLsWCl75jBxMp1OX2fo9EZ
	+U6kexvJ2uXdqhMF7OweiZ6IGvilu8wqshZav87qCqAwJHF665shWRlnBjWad29NgLK6cRgZd/v
	jge7GYKI7LM0v1cgz3yKfCfY1lL9MXYcJdK4+I5Pog1+GJE0bp6+Do2sIC3GYLZL8YaOAICSz08
	7zvXKniOIMpCi5ipnBIOsnWLz3NmUenC51VRBKunzroO8fYq3kR30HvIcpfPThrd7wYi/sG+F5k
	nVoVhDK8HniE8Y3VZi5u2qzkrxC4OUh2JRw==
X-Google-Smtp-Source: AGHT+IGv/35p/W7r3GHx5SA997jhumk8Hh17nHWyXFsjPVhFKF0I3tiZFXsC/nBQd4qsEp3pwnV0nA==
X-Received: by 2002:a05:600c:548f:b0:45b:8ad2:76c8 with SMTP id 5b1f17b1804b1-45f2125d5cdmr28593575e9.2.1757678927561;
        Fri, 12 Sep 2025 05:08:47 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:18f9:fa9:c12a:ac60])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e037186e5sm60557925e9.5.2025.09.12.05.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 05:08:47 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,  Jakub Kicinski <kuba@kernel.org>,
  "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Simon Horman
 <horms@kernel.org>,  linux-doc@vger.kernel.org,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] tools: ynl: rst: display attribute-set doc
In-Reply-To: <a1f55940-7115-4650-835c-2f1138c5eaa4@kernel.org>
Date: Fri, 12 Sep 2025 12:07:04 +0100
Message-ID: <m2ecscudyf.fsf@gmail.com>
References: <20250910-net-next-ynl-attr-doc-rst-v1-1-0bbc77816174@kernel.org>
	<m2v7lpuv2w.fsf@gmail.com>
	<a1f55940-7115-4650-835c-2f1138c5eaa4@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Matthieu Baerts <matttbe@kernel.org> writes:

> Hi Donald,
>
> On 11/09/2025 12:44, Donald Hunter wrote:
>> "Matthieu Baerts (NGI0)" <matttbe@kernel.org> writes:
>> 
>>> Some attribute-set have a documentation (doc:), but it was not displayed
>>> in the RST / HTML version. Such field can be found in ethtool, netdev,
>>> tcp_metrics and team YAML files.
>>>
>>> Only the 'name' and 'attributes' fields from an 'attribute-set' section
>>> were parsed. Now the content of the 'doc' field, if available, is added
>>> as a new paragraph before listing each attribute. This is similar to
>>> what is done when parsing the 'operations'.
>> 
>> This fix looks good, but exposes the same issue with the team
>> attribute-set in team.yaml.
>
> Good catch! I forgot to check why the output was like that before
> sending this patch.
>
>> The following patch is sufficient to generate output that sphinx doesn't
>> mangle:
>> 
>> diff --git a/Documentation/netlink/specs/team.yaml b/Documentation/netlink/specs/team.yaml
>> index cf02d47d12a4..fae40835386c 100644
>> --- a/Documentation/netlink/specs/team.yaml
>> +++ b/Documentation/netlink/specs/team.yaml
>> @@ -25,7 +25,7 @@ definitions:
>>  attribute-sets:
>>    -
>>      name: team
>> -    doc:
>> +    doc: |
>>        The team nested layout of get/set msg looks like
>>            [TEAM_ATTR_LIST_OPTION]
>>                [TEAM_ATTR_ITEM_OPTION]
> Yes, that's enough to avoid the mangled output in .rst and .html files.
>
> Do you plan to send this patch, or do you prefer if I send it? As part
> of another series or do you prefer a v2?

Could you add it to a v2 please.

> Note that a few .yaml files have the doc definition starting at the next
> line, but without this '|' at the end. It looks strange to me to have
> the string defined at the next line like that. I was thinking about
> sending patches containing modifications created by the following
> command, but I see that this way of writing the string value is valid in
> YAML.
>
>   $ git grep -l "doc:$" -- Documentation/netlink/specs | \
>         xargs sed -i 's/doc:$/doc: |/g'
>
> Except the one with "team", the other ones don't have their output
> mangled. So such modifications are probably not needed for the other ones.

Yeah, those doc: entries look weird to me too. Not sure it's worth
fixing them up, given that they are valid. Also worth noting that the
two formats that we should encourage are

  doc: >-
    Multi line text that will get folded and
    stripped, i.e. internal newlines and trailing
    newlines will be removed.

  doc: |
    Multi line text that will be handled literally
    and clipped, i.e. internal newlines and trailing
    newline are preserved but additional trailing
    newlines get removed.

So if we were to fix up the doc:$ occurrences, then I'd suggest using
doc: >-

Cheers,
Donald

