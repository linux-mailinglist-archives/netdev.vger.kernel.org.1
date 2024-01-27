Return-Path: <netdev+bounces-66425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2799D83EF02
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 18:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83B12B22800
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 17:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8442C848;
	Sat, 27 Jan 2024 17:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aq0pmRTJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3C941C85;
	Sat, 27 Jan 2024 17:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706376096; cv=none; b=ZVYyr38dZHjSuTUqUUjxBfGMavWRl601QvXfqHkXBO9DQxsYZUDpRU0hssw4bKV2nLnEM3GY/bqLVUzyuwz5cq5kcmuvRCyBW2ayUkbAfX8CPETSvUM/cQbJ4FtFCbonaTBpmekL3wD0HQKZeUHrmjJqKmD4ARBjhbHIkczwXS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706376096; c=relaxed/simple;
	bh=SSKCKiL1YnmxVg4Xe2YdM3ktiD4jdScuF5ZZ9Iu0qBo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=CJsDJ7jeQsaSJjQuJLoZwflcdJ+AznuH0yL3HAwZKm0htCtnnhvaaPR4NOpwJ+9PqYJuOwTXBzaGlaCtKVZ2MrdxGfh7zjRF64RZrrW3kyA96g332I8ra3kIxZwLXVg+YSDpHIM4SUYGuA2Dj2SjQMDF0CUacGK0PeZUZLcMwmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aq0pmRTJ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40ee6ff0c7dso23468965e9.2;
        Sat, 27 Jan 2024 09:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706376093; x=1706980893; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p4rUlkt+rkv6CMzRlHN8tQkvwBQfgooo3skIas42+XQ=;
        b=aq0pmRTJb8Ktx6xUvOGwWmEu3xX2agsUYcmKtDNyo3T6j1s64vnK1GYyCmLAL66ITE
         3owZlGe46MEMWrpZAmBvCnsIBStFwgeSDwPzQ25oaoVPiPbAFid/nQUF5g2kxeGpu2sz
         idvqf37euqPCOAqPiZF2qMEhBz8zFO/woZ/3R0x0P6qJGmLJziBqEz+srhThwR/ICb3v
         G+cHLxgcVgxp+3178JL37fJYleVmDDou0FhzOU4ZNhoYiFn2irkOBHBaE8MJW92YVmRb
         xmhx/kNRwdfc2ffe8/X+gap6q/YVpQvlU955xv7ctajJa/KalMw+mFNv1/MlJHwLpIXW
         UlKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706376093; x=1706980893;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4rUlkt+rkv6CMzRlHN8tQkvwBQfgooo3skIas42+XQ=;
        b=XJCkn+kjFw8mJ5enCRlJC977NWPAO8uK3w0i6BBvBnu14P4oAte345gWCFeeHpf6Fh
         TUDbOwQYDhyHt346Xe/VlJ57TLL5XLR5QYmCrzh452awPLA0Vo/Hb0DMbbWOJ3PLA/r5
         wI/5AYwl76Y9qPBc3Yn02uzoKN1Xab+QNF9V3umuZ+RR8b2LYlolpJ96QJDz+xQPljnD
         fV7f+5reoihXQApKKiwxL4v11ykG1AzvhO1euRvZTn3NNr6cKGBekVDhu3kCuyWAUkno
         fqrSeiVw+7uPqa9GUV7b+571IoVDp4jWtcCX/sLXP13KDpszNRo/YoJcqhDgXtyIs1cC
         lzXg==
X-Gm-Message-State: AOJu0YxV/N8Zc/JItF/+if3bw+97yUSBG357L/xK3lx67EskNP5MEVF9
	BgmyHR/aYvhy7VXeuM455qUoAahgMpF6WTP+/lItvqAilZUo5Jf1
X-Google-Smtp-Source: AGHT+IEykak8nMEthRNEOLdrc5G/3NUS1bjO42TT+WZeXNsbkDU3/NKRGX5nAV+6KsWFQ/GjppYu6Q==
X-Received: by 2002:a05:600c:5494:b0:40e:c31b:653d with SMTP id iv20-20020a05600c549400b0040ec31b653dmr1307114wmb.39.1706376092417;
        Sat, 27 Jan 2024 09:21:32 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:61a5:32a6:6851:46ff])
        by smtp.gmail.com with ESMTPSA id z5-20020adfe545000000b00338ca0ada22sm3876484wrm.111.2024.01.27.09.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 09:21:31 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Jonathan
 Corbet <corbet@lwn.net>,  linux-doc@vger.kernel.org,  Jacob Keller
 <jacob.e.keller@intel.com>,  Breno Leitao <leitao@debian.org>,  Jiri Pirko
 <jiri@resnulli.us>,  Alessandro Marcolini
 <alessandromarcolini99@gmail.com>,  donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 02/12] tools/net/ynl: Support sub-messages
 in nested attribute spaces
In-Reply-To: <20240126105055.2200dc36@kernel.org> (Jakub Kicinski's message of
	"Fri, 26 Jan 2024 10:50:55 -0800")
Date: Sat, 27 Jan 2024 17:18:59 +0000
Message-ID: <m2jznuwv7g.fsf@gmail.com>
References: <20240123160538.172-1-donald.hunter@gmail.com>
	<20240123160538.172-3-donald.hunter@gmail.com>
	<20240123161804.3573953d@kernel.org> <m2ede7xeas.fsf@gmail.com>
	<20240124073228.0e939e5c@kernel.org> <m2ttn0w9fa.fsf@gmail.com>
	<20240126105055.2200dc36@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> On Fri, 26 Jan 2024 12:44:57 +0000 Donald Hunter wrote:
>> I was quite pleased with how simple the patch turned out to be when I
>> used ChainMap, but it does have this weakness.
>
> It is very neat, no question about it :(
>
>> In practice, the only place this could be a problem is with
>> tc-act-attrs which has the same attribute name 'kind' in the nest and
>> in tc-attrs at the top level. If you send a create message with ynl,
>> you could omit the 'kind' attr in the 'act' nest and ynl would
>> incorrectly resolve to the top level 'kind'. The kernel would reject
>> the action with a missing 'kind' but the rest of payload would be
>> encoded wrongly and/or could break ynl.
>
> We can detect the problem post-fact and throw an exception. I primarily
> care about removing the ambiguity.

Agreed.

> Is it possible to check at which "level" of the chainmap the key was
> found? If so we can also construct a 'chainmap of attr sets' and make
> sure that the key level == attr set level. I.e. that we got a hit at
> the first level which declares a key of that name.
>
> More crude option - we could construct a list of dicts (the levels
> within the chainmap) and keys they can't contain. Once we got a hit
> for a sub-message key at level A, all dicts currently on top of A
> are not allowed to add that key. Once we're done with the message we
> scan thru the list and make sure the keys haven't appeared?
>
> Another random thought, should we mark the keys which can "descend"
> somehow? IDK, put a ~ in front?
>
> 	selector: ~kind
>
> or some other char?

Okay, so I think the behaviour we need is to either search current scope
or search the outermost scope. My suggestion would be to replace the
ChainMap approach with just choosing between current and outermost
scope. The unusual case is needing to search the outermost scope so
using a prefix e.g. '/' for that would work.

We can have 'selector: kind' continue to refer to current scope and then
have 'selector: /kind' refer to the outermost scope.

If we run into a case that requires something other than current or
outermost then we could add e.g. '../kind' so that the scope to search
is always explicitly identified.

>> My initial thought is that this might be better handled as input
>> validation, e.g. adding 'required: true' to the spec for 'act/kind'.
>> After using ynl for a while, I think it would help to specify required
>> attributes for messages, nests and sub-messsages. It's very hard to
>> discover the required attributes for families that don't provide
>> extack responses for errors.
>
> Hah, required attrs. I have been sitting on patches for the kernel for
> over a year - https://github.com/kuba-moo/linux/tree/req-args
> Not sure if they actually work but for the kernel I was curious if it's
> possible to do the validation in constant time (in relation to the
> policy size, i.e. without scanning the entire policy at the end to
> confirm that all required attrs are present). And that's what I came up
> with.

Interesting. It's definitely a thorny problem with varying sets of
'required' attributes. It could be useful to report the absolutely
required attributes in policy responses, without any actual enforcement.
Would it be possible to report policy for legacy netlink-raw families?

Thinking about it, usability would probably be most improved by adding
extack messages to more of the tc error paths.

> I haven't posted it because I was a tiny bit worried that required args
> will cause bugs (people forgetting to null check attrs) and may cause
> uAPI breakage down the line (we should clearly state that "required"
> status is just advisory, and can go away in future kernel release).
> But that was more of a on-the-fence situation. If you find them useful
> feel free to move forward!
>
> I do think that's a separate story, tho. For sub-message selector
> - isn't the key _implicitly_ required, in the first attr set where
> it is defined? Conversely if the sub-message isn't present the key
> isn't required any more either?

Yes, the key is implicitly required for sub-messages. The toplevel key
is probably required regardless of the presence of a sub-message.

