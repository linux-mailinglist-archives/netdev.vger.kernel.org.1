Return-Path: <netdev+bounces-206119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CB1B01A61
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 13:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06A0E7BD8AD
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 11:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9D828BAB0;
	Fri, 11 Jul 2025 11:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0xg6L34"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E623028B7E6;
	Fri, 11 Jul 2025 11:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752232511; cv=none; b=tE9HWK94MhPRVo6a3PNkj9vFYiJ3dE+fs8gM9vwG3rQYlyREqeQEDnVJz/1d90shiMCxeNfaljMiPIFkWLX7BVDPSbZ5L10q7Zl8aWzodI2aYy+xFjpKZEY7ttdmrSpn1kMZr+edhBP1GnuhjnCct1glUXRSvM8wEI83niC2IDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752232511; c=relaxed/simple;
	bh=uRVELgRW5ZYzlSpEJR0P6N1J9NFxpV2TWeTwAHBtgDk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=iYWO79iwM51mCwjepGZtivW/wLH0tQxUsy5674PIaI/jmFlINA/RPxY7XYsvDxD7enVcQb1hUgLbMUSTknqvppMxE+PIG1RV0JLdV2zZi0z7KBOoLfQuxpgA4W9rxDLGdsCvr0nd8WY0ntEp2wAU46wXlYpCF1/Tq+1P3W1C/F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0xg6L34; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-455ecacfc32so1692815e9.3;
        Fri, 11 Jul 2025 04:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752232508; x=1752837308; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zQ6vVLhKfs0npq6T/CCDFR1z9xriix4gqXPfUihkmJ4=;
        b=g0xg6L3417l/LU2xYSjHi+HCi2wpKM69VOqIarDseBFjTW828YvjU/odpVELE+oS0f
         EoPn9BbxOjj/hg2H/zB3g66LgY2+onZfFlqKyemKhUWZs2MR1Yt1Xj+V3Wwwhh//uLw/
         O5HDxq4BdRjWnLfUOhlxeEh3wKIFjk5BM/q5MmlZGnn8OpzaCu6qhmxqFouPpCHsat9H
         kQoMde6dsWp7HRYsIeS4HAptQ4XqCs+S/DlzNI58Ql5/CfrH4af1M7h+y+sl4bj47mG0
         xY0jlKTN9aa3bwi4KUES8e1ljEvl09a/xWf7PW4OnSA408a/YEHmJMu7aP9h2E5/Yc32
         MgZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752232508; x=1752837308;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQ6vVLhKfs0npq6T/CCDFR1z9xriix4gqXPfUihkmJ4=;
        b=V4eGwGiM/MJphg3IbJKSNck/zcZx5sppIsvngfAfkmIr5iC0EMzYNt71FU7nYyDRee
         3CjbSE7INwiip1lZlIlQS+MpouT9/P2gcTfTCHiL7ogHVXQRO1DhbU3foEEChRYUJchb
         U1kUZo8RveyAd5HW9y3BguyCdUrs4eINHecI1IfmA8/gqe00Ii+Go21ufuLAixgutSf8
         rbPJDr77wvF2iCOif7bFfe/lwvwiSH/je56SuKmd6N3Gogs0UCfA5F3mKdq+PadaPzI3
         ijpRynxZdZGfg3HwnQOO0ithC2BFoXltHHHO2vP2IL6apAS781qdKuaXdxxWNshvUJTf
         rOPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzvY8SZnNoqpapbr9Q1xskLmvR0SKbieKsIIOJBc85eknSraPZU/g85wl78gi1olOOPLNmCd8c@vger.kernel.org, AJvYcCWAsEb1yBxWRrxJy2744btHdXOPbg1P752uZERg89E81rznlfhazpnTjN0kje+IPG09LkbajwNEOfMw9Yo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys6645GHT+xRkh+RZiqiB23nJWf9oGeqMzcesN2Er9VuKzazOR
	cPw8RPwMpEwGUoPU3SMCpqiQwxc0YYOZOPrTUrxMKCa+a/f2ak5Kw/uA
X-Gm-Gg: ASbGncu6kC/Y9UVW/owACFy0Dsa1xhk5A4oYCHxMs6KJ0Ce8Ttnd3KIH1J2jaU81aQk
	ID0vtuczg23+dqMT+rqvWEgi8qaYvoWSe/Qa7J2kXokcXcWznGGbI4IZ0dPqltIcJxCPZjqA5KL
	/oM4IidtGWeo+nzpp0Pz1IflXz/kxXFXO1fDB7SI/KCBfptEPpAhmwKLRgCFbCqAk2PKirEgDf3
	XwcFO7Jy+RzdvMjEfr5ekebIH+Jtwir9dxs6AhRGS+8vK03r6cXwLt8aNijij154geShLR/wROf
	9e3NKuR6FGcNZ0+6tmrfvbpB9Pfz0q+YzCJeG9bjHMI0gtH0iIEzHp0vcKv3KkFYNBWU16MbLiU
	D/hHPgwjKF6hnDdMsqkFBxe+MTXtP3Wolv4I=
X-Google-Smtp-Source: AGHT+IHfWOXs/DQWPgcsYx/QQ97AdyzdjpEj41AjPGIMDl3KDPOv7Lr5iAfD6MZXLS+UtNQxmkt6GA==
X-Received: by 2002:a05:600c:a00e:b0:43c:fe90:1279 with SMTP id 5b1f17b1804b1-45565ed62e0mr15833755e9.21.1752232507853;
        Fri, 11 Jul 2025 04:15:07 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:4586:9b2f:cef2:6790])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc23cfsm4263566f8f.37.2025.07.11.04.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 04:15:07 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,  Jonathan Corbet
 <corbet@lwn.net>,  "Akira Yokosawa" <akiyks@gmail.com>,  "Breno Leitao"
 <leitao@debian.org>,  "David S. Miller" <davem@davemloft.net>,  "Eric
 Dumazet" <edumazet@google.com>,  "Ignacio Encinas Rubio"
 <ignacio@iencinas.com>,  "Jan Stancek" <jstancek@redhat.com>,  "Marco
 Elver" <elver@google.com>,  "Paolo Abeni" <pabeni@redhat.com>,  "Randy
 Dunlap" <rdunlap@infradead.org>,  "Ruben Wauters" <rubenru09@aol.com>,
  "Shuah Khan" <skhan@linuxfoundation.org>,  Jakub Kicinski
 <kuba@kernel.org>,  Simon Horman <horms@kernel.org>,
  joel@joelfernandes.org,  linux-kernel-mentees@lists.linux.dev,
  linux-kernel@vger.kernel.org,  lkmm@lists.linux.dev,
  netdev@vger.kernel.org,  peterz@infradead.org,  stern@rowland.harvard.edu
Subject: Re: [PATCH v9 12/13] docs: parser_yaml.py: add support for line
 numbers from the parser
In-Reply-To: <20250710195757.02e8844a@sal.lan>
Date: Fri, 11 Jul 2025 10:51:37 +0100
Message-ID: <m2ecun5a3a.fsf@gmail.com>
References: <cover.1752076293.git.mchehab+huawei@kernel.org>
	<3b18b30b1b50b01a014fd4b5a38423e529cde2fb.1752076293.git.mchehab+huawei@kernel.org>
	<m2zfdc5ltn.fsf@gmail.com> <m2ms9c5din.fsf@gmail.com>
	<20250710195757.02e8844a@sal.lan>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Em Thu, 10 Jul 2025 15:25:20 +0100
> Donald Hunter <donald.hunter@gmail.com> escreveu:
>
>> Donald Hunter <donald.hunter@gmail.com> writes:
>> 
>> >>              # Parse message with RSTParser
>> >> -            for i, line in enumerate(msg.split('\n')):
>> >> -                result.append(line, document.current_source, i)
>> >> +            lineoffset = 0;
>> >> +            for line in msg.split('\n'):
>> >> +                match = self.re_lineno.match(line)
>> >> +                if match:
>> >> +                    lineoffset = int(match.group(1))
>> >> +                    continue
>> >> +
>> >> +                result.append(line, document.current_source, lineoffset)  
>> >
>> > I expect this would need to be source=document.current_source, offset=lineoffset  
>> 
>> Ignore that. I see it's not kwargs. It's just the issue below.
>> 
>> >>              rst_parser = RSTParser()
>> >>              rst_parser.parse('\n'.join(result), document)  
>> >
>> > But anyway this discards any line information by just concatenating the
>> > lines together again.  
>> 
>> Looks to me like there's no Parser() API that works with ViewList() so
>> it would be necessary to directly use the docutils RSTStateMachine() for
>> this approach to work.
>
> It sounds so.
>
> The enclosed patch seems to address it:
>
> 	$ make cleandocs; make SPHINXDIRS="netlink/specs" htmldocs
> 	...
> 	Using alabaster theme
> 	source directory: netlink/specs
> 	Using Python kernel-doc
> 	/new_devel/v4l/docs/Documentation/netlink/specs/rt-neigh.yaml:13: ERROR: Unknown directive type "bogus".
>
> 	.. bogus:: [docutils]
>
> Please notice that I added a hunk there to generate the error, just
> to make easier to test - I'll drop it at the final version, and add
> the proper reported-by/closes/... tags once you test it.
>
> Regards,
> Mauro

Awesome!

Tested-by: Donald Hunter <donald.hunter@gmail.com>

Patch comments below.

> [PATCH RFC] sphinx: parser_yaml.py: preserve line numbers
>
> Instead of converting viewlist to text, use it directly, if
> docutils supports it.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>
> diff --git a/Documentation/netlink/specs/rt-neigh.yaml b/Documentation/netlink/specs/rt-neigh.yaml
> index e9cba164e3d1..937d2563f151 100644
> --- a/Documentation/netlink/specs/rt-neigh.yaml
> +++ b/Documentation/netlink/specs/rt-neigh.yaml
> @@ -11,6 +11,7 @@ doc:
>  definitions:
>    -
>      name: ndmsg
> +    doc: ".. bogus::"
>      type: struct
>      members:
>        -
> diff --git a/Documentation/sphinx/parser_yaml.py b/Documentation/sphinx/parser_yaml.py
> index 1602b31f448e..2a2faaf759ef 100755
> --- a/Documentation/sphinx/parser_yaml.py
> +++ b/Documentation/sphinx/parser_yaml.py
> @@ -11,7 +11,9 @@ import sys
>  
>  from pprint import pformat
>  
> +from docutils import nodes, statemachine

nodes is not used

>  from docutils.parsers.rst import Parser as RSTParser

This import is no longer needed

> +from docutils.parsers.rst import states
>  from docutils.statemachine import ViewList
>  
>  from sphinx.util import logging
> @@ -66,10 +68,24 @@ class YamlParser(Parser):

I'm wondering if it makes much sense for this to inherit from Parser any
more?

>  
>          result = ViewList()
>  
> +        tab_width = 8
> +
> +        self.state_classes = states.state_classes
> +        self.initial_state = 'Body'
> +
> +        self.statemachine = states.RSTStateMachine(
> +              state_classes=self.state_classes,
> +              initial_state=self.initial_state,
> +              debug=document.reporter.debug_flag)

I don't think 'self.' is needed for any of these. They can be local to
the method. You could just inline states.state_classes and 'Body' into
the parameter list.

> +
>          try:
>              # Parse message with RSTParser

Comment is out of date.

>              lineoffset = 0;

Rogue semicolon

> -            for line in msg.split('\n'):
> +
> +            lines = statemachine.string2lines(msg, tab_width,
> +                                            convert_whitespace=True)
> +
> +            for line in lines:
>                  match = self.re_lineno.match(line)
>                  if match:
>                      lineoffset = int(match.group(1))
> @@ -77,12 +93,7 @@ class YamlParser(Parser):
>  
>                  result.append(line, document.current_source, lineoffset)
>  
> -            # Fix backward compatibility with docutils < 0.17.1
> -            if "tab_width" not in vars(document.settings):
> -                document.settings.tab_width = 8
> -
> -            rst_parser = RSTParser()
> -            rst_parser.parse('\n'.join(result), document)
> +            self.statemachine.run(result, document, inliner=None)
>  
>          except Exception as e:

I think you could catch StateMachineError here.

>              document.reporter.error("YAML parsing error: %s" % pformat(e))

Can you change this to an f"" string.

