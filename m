Return-Path: <netdev+bounces-97335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 758788CAE61
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 14:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06D5E1F220A1
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 12:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EAB75811;
	Tue, 21 May 2024 12:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="OpYhDLpM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF58219EA
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 12:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716294921; cv=none; b=R5NJkcJEXkORh+e8v5Jegsz3YGpvciS1zWBN6cUTTWv0iTb+gMnisdo3eIeYp85hu4ivto5cgjzyj1lBi/m1DQIDQO1LOXw++4IWtQWBSCkDQixophOcXvWIM0JQhBiO6QlSQz+O0cYkFwrEip63cPjP5cLb0yUQn6ZnJ5BlzCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716294921; c=relaxed/simple;
	bh=HABtfUr6wHg3IQCNHw1tVM/wml9YbMFqp7NRcxzIM7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=omjiqgZjNCYs0GP0rc+sAp5j/GRmLjLpS/PuUMFOn+w6x4NfRIhcL0pk6QfTNsP+nTGHwheood8VG/hol5v9SHU1cOY58a0M4RAkT4JptJjcffrfg8Pj2FT4xyV/NLjNJWKFsdoF3l6SGNVr5NUv8B+lHOdB6W8fQEfKrgURtRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=OpYhDLpM; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-61b4cbb8834so31612207b3.0
        for <netdev@vger.kernel.org>; Tue, 21 May 2024 05:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1716294919; x=1716899719; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HABtfUr6wHg3IQCNHw1tVM/wml9YbMFqp7NRcxzIM7E=;
        b=OpYhDLpMLM8lLhtihAB6isC1D6iEbKLV4XElofJyWwccS01evQBUC2+CmKFtxJNdnI
         AZYa3cv2pNyj05py8TwIpmKjddlHHyCJ1I8f9oIXkYDVuAwdoLx9FjI4vysc9R4JjgXP
         HR0u0tianbw4S8+XC3ac1+kAqzne72nzg9FGeegWy2x9Rl8Cr6XKeE9VAkWoSB/CLVvS
         ++II1p7uyuJSkzGogb2kyStt2ZoT6zq7GkRgMnpR0hK2fh8kMx908Y36mKWNH25E8eNy
         mOfl/iJvwgzBfYcVg3gkJMiulRTPqVzVK+7jWWhZGQhZ+45xAVl/HKhUl23vW+Ej1SIT
         iOwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716294919; x=1716899719;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HABtfUr6wHg3IQCNHw1tVM/wml9YbMFqp7NRcxzIM7E=;
        b=pkP6v0VOqI/8NXFQNG5yVnwCoZ1tw2YuKLQ7euyHTAknRq/a15gG9YTQm6GbEj2GKQ
         V/ETcVAiO+b87Go69G+C5zHfl1sS14hNtNyzGNDLpnxh6LfbBgWmjaw9seezIQ8W0iaF
         Ohair3V7gZWKMrYn84tD2yCSE3R/BVL355lLjkJwsmF4bfDYkghIeHT4Af+mZUxX698t
         4oSzpWXNsjKaog+fyiUZItuRseGIUdkN5DhZGkWAoHzNpDKNDh9FjNk0mjxmO6uxHLNr
         eX57hV4N2gN0yd43RIF50LTZpDNQwQZr89Y958/2v5+g3dGJvQO/8+5GYnsBQMEJmCnH
         qlrg==
X-Forwarded-Encrypted: i=1; AJvYcCW19H/6DjItLnGrS0vf28UneWNkzFZaXeCT17IJPZx0mOXvSASjQCWJXcN4ob6nIe6T7NcyI6Prbbv6VVvmMhT3DkBfoCDf
X-Gm-Message-State: AOJu0Yx48TYKUrvSuNam+TdtPHJfYhEBJpFwFvVvmB217B8rIFcKZb9R
	f1EApTxiU8Weqldsem8EIL2wbafEoAu0QvtHvUENSzQ0fvujWgOU8uEt0o11vckY3pF5KpIpna+
	O2b+5jQ8WRpXM8LECFEC3REpY7ktWrEb1CMbl
X-Google-Smtp-Source: AGHT+IGqgZEJHg+PMqQ32lsx1dAhh3ttCrHFm4uv/mja2rTb8hQ0HnLwXjrEHlI97NnkZQEQkD5JwEVrMFVyjVMsc0Q=
X-Received: by 2002:a05:690c:60c1:b0:61b:92d9:f7e8 with SMTP id
 00721157ae682-622affc09ebmr399755867b3.23.1716294919363; Tue, 21 May 2024
 05:35:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410140141.495384-1-jhs@mojatatu.com> <41736ea4e81666e911fee5b880d9430ffffa9a58.camel@redhat.com>
 <CAM0EoM=982OctjvSQpx0kR7e+JnQLhvZ=sM-tNB4xNiu7nhH5Q@mail.gmail.com>
 <CAM0EoM=VhVn2sGV40SYttQyaiCn8gKaKHTUqFxB_WzKrayJJfQ@mail.gmail.com>
 <87cf4830e2e46c1882998162526e108fb424a0f7.camel@redhat.com>
 <CAM0EoMkJwR0K-fF7qo0PfRw4Sf+=2L0L=rOcH5A2ELwagLrZMw@mail.gmail.com>
 <CAM0EoMmfDoZ9_ZdK-ZjHjFAjuNN8fVK+R57_UaFqAm=wA0AWVA@mail.gmail.com>
 <82ee1013ca0164053e9fb1259eaf676343c430e8.camel@redhat.com>
 <CAADnVQLugkg+ahAapskRaE86=RnwpY8v=Nre8pn=sa4fTEoTyA@mail.gmail.com>
 <CAM0EoM=2wHem54vTeVq4H1W5pawYuHNt-aS9JyG8iQORbaw5pA@mail.gmail.com> <CAM0EoMmCz5usVSLq_wzR3s7UcaKifa-X58zr6hkPXuSBnwFX3w@mail.gmail.com>
In-Reply-To: <CAM0EoMmCz5usVSLq_wzR3s7UcaKifa-X58zr6hkPXuSBnwFX3w@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 21 May 2024 08:35:07 -0400
Message-ID: <CAM0EoMmsB5jHZ=4oJc_Yzm=RFDUHWh9yexdG6_bPFS4_CFuiog@mail.gmail.com>
Subject: On the NACKs on P4TC patches
To: Paolo Abeni <pabeni@redhat.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Network Development <netdev@vger.kernel.org>, "Chatterjee, Deb" <deb.chatterjee@intel.com>, 
	Anjali Singhai Jain <anjali.singhai@intel.com>, "Limaye, Namrata" <namrata.limaye@intel.com>, 
	tom Herbert <tom@sipanda.io>, Marcelo Ricardo Leitner <mleitner@redhat.com>, 
	"Shirshyad, Mahesh" <Mahesh.Shirshyad@amd.com>, "Osinski, Tomasz" <tomasz.osinski@intel.com>, 
	Jiri Pirko <jiri@resnulli.us>, Cong Wang <xiyou.wangcong@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Vlad Buslov <vladbu@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Khalid Manaa <khalidm@nvidia.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, 
	"Jain, Vipin" <Vipin.Jain@amd.com>, "Daly, Dan" <dan.daly@intel.com>, 
	Andy Fingerhut <andy.fingerhut@gmail.com>, Chris Sommers <chris.sommers@keysight.com>, 
	Matty Kadosh <mattyk@nvidia.com>, bpf <bpf@vger.kernel.org>, lwn@lwn.net
Content-Type: text/plain; charset="UTF-8"

As stated a few times, we strongly disagree with the nature of the
Nacks from Alexei, Daniel and John. We dont think there is good ground
for the Nacks.

A brief history on the P4TC patches:

We posted V1 in January 2023. The main objection then was that we
needed to use eBPF. After some discussion and investigation on our
part we found that using kfuncs would satisfy our goals as well as the
objections raised. We posted 28 RFC patches looking for feedback from
eBPF and other folks with V2 in May 2023 - these patches were not
ready but we were nevertheless soliciting for feedback. By Version 7
in October/2023 we removed the RFC tag (meaning we are asking for
inclusion). In Version 8 we sent the first 15 patches as series
1(following netdev rules that allow only 15 patches); 5 of these
patches are trivial tc core patches. Starting with V8 and upto V14 the
releases were mostly suggested changes (much thanks to folks who made
suggestions for technical changes) and at one point it was a bug fix
for an issue caught by our syzkaller instance.

When it seemed like Paolo was heading towards applying series 1 given
the feedback, Alexei nacked patch 14 when we released V14, see:
https://lore.kernel.org/bpf/20240404122338.372945-5-jhs@mojatatu.com/
V15 only change was adding Alexei's nack. V15 was followed by Daniel
and then John also nacking the same patch 14. V16's only change was to
add these extra Nacks.

At that point(v16) i asked for the series to be applied despite the
Nacks because, frankly, the Nacks have no merit. Paolo was not
comfortable applying patches with Nacks and tried to mediate. In his
mediation effort he asked if we could remove eBPF - and our answer was
no because after all that time we have become dependent on it and
frankly there was no technical reason not to use eBPF. Paolo then
asked if we could satisfy one of the points Alexei raised in terms of
clearing table entries when an eBPF program was unloaded. We spent a
week investigating and came to a conclusion that we could do it as a
compromise (even though it is not something fitting to our
requirements and there is existing code that we copied from doing
exactly what Alexei is objecting to). Alexei rejected this offer. This
puts Paolo in a difficult position because it is clear there is no
compromise to be had. I feel we are in uncharted teritory.

Since we are in a quagmire, I am asking for a third party mediator to
review the objections and validate if they have merit.
I have created a web page to capture all the objections raised by the
3 gents over a period of time at:
https://github.com/p4tc-dev/pushback-patches
If any of the 3 people feel i have misrepresented their objections or
missed an important detail please let me know and i will fix the page.

cheers,
jamal

