Return-Path: <netdev+bounces-76894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E3886F47E
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 11:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84D2F1F2193D
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 10:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0203B664;
	Sun,  3 Mar 2024 10:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hii7YtIi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5345CB64C
	for <netdev@vger.kernel.org>; Sun,  3 Mar 2024 10:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709463023; cv=none; b=quaXN7zQ4gwNOpU5xqkHghOopdX4u6LDpYgxulwvhibY8OqTtN+3ZRPW0rrVCxVg642bAx+y+rTA/1cg2K0ef8raARUI+ScWJhpUcD2wjowyR3RsUzZY9g4Qkl7OEGvZQ9cHwa8YutzH6BQEqdvENhN3grf8jVNq9ArZwJsu8ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709463023; c=relaxed/simple;
	bh=TA6TNq7nLgKXMjPyTH6GC9izItXtXJJeHDjbqO8dTkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S9hIC4rlRVHz11LFR1uD6Fvezz9k+xxjMJ00ibLGbIaZMZVxShnhhKsb4GfBUpHqP6t7ingWHbtiFnwtuS40qfIkaYp0iD9iJuEgPTbXalx9h6hGN1bR9+2npzajisLqHQeulesCQjt7vSw8qB3ytWwfxn5dX4HkmBKwNNqpGfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hii7YtIi; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-21e6be74db4so2017440fac.2
        for <netdev@vger.kernel.org>; Sun, 03 Mar 2024 02:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709463021; x=1710067821; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tSaVDD5QKjBbeNjjwQqxXzVXhxfUdNqnO1w/wDi/VPM=;
        b=Hii7YtIiTAQKwzbRE0VkE/0yuDwn/zveIJuO8fegKjzUBjf0fzXAznAUqiR8e0OI0i
         ebBmeiLDBPHGRCD47JfplmHkDTUqbhRFU/Jvyc4VHmI+gJoABFu19hRvLgEoQgmckIY4
         bIENZ5Z9ce8HuOJqSIHMM2nFdpD+y86toB6VpuGmkHp6M8tozLs2tKkOYzjeVa3n1DQM
         XGmKQKbmkCYxXIkhxmLFnxdj5BmnECjSX8DFLA8TN/N/IcsTjxUpFWJ0sJOhC5sX1DMT
         vc9IH83FeXAOHCu/EXvlJHnJ8LIv3EwSQTqzMVKz+N69B2TKy9rUxO6SLa4FFdWESJJd
         ZM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709463021; x=1710067821;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tSaVDD5QKjBbeNjjwQqxXzVXhxfUdNqnO1w/wDi/VPM=;
        b=Zy47/C7KPF/HlxDNzCSHh1ri6uN/3gB+Ewtcri3Lg+GJS9OtK5tZAhF+YDA8oUZQSB
         7uduHWP5QlvUP8zljiyu2CAV7hCtKL24VdgS+L7Df1xhwFWAJ3ohfcKVIZoqgMkDo/rn
         hSF7/pAWsCeAj9NBWQuEwnQT04fFzGWlC9E/vEqG/057pjeTfLaPICNe1Q4+3ykN/ks1
         d5xHdI+zjqBS6vHLFwq5ffAUiCDEHjfa02iMCREFpgW+ws5Ai1sMZpfxYceMkUEpsoWk
         BHpoh7JsDj1iXyyK5HDxBfDQYt4xjQmKsns0EYoNjR/gIDaKO9/nTqq+pp94yKrIQtFR
         iDuA==
X-Gm-Message-State: AOJu0YxeLIV9nsu9vBft1XsiPy4VJgZd4yYptAUGjuHHjXRq3eVmQV1c
	63nNJR5vB5HccAhSRyv/Sp3ZW0M6AWFlJvVwVPEnLvzjMxzjJeDHp31HYGw47CJK+9iTGjIxY0+
	/kBe98e+PL3BkThV2+vRJEr6UMrI=
X-Google-Smtp-Source: AGHT+IEYSdL84gQLT7+Cf/zdFmFYDZ+bVX9R9dqjS6OKmM0KVU7EBPF3byYcORpyLfIh0qpT5LwAXbBxbpMpuRY7vdI=
X-Received: by 2002:a05:6870:cd15:b0:220:873d:dbcc with SMTP id
 qk21-20020a056870cd1500b00220873ddbccmr7512896oab.49.1709463020944; Sun, 03
 Mar 2024 02:50:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301171431.65892-1-donald.hunter@gmail.com>
 <20240301171431.65892-4-donald.hunter@gmail.com> <20240302200536.511a5078@kernel.org>
In-Reply-To: <20240302200536.511a5078@kernel.org>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Sun, 3 Mar 2024 10:50:09 +0000
Message-ID: <CAD4GDZwHXNM++G3xDgD_xFk1mHgxr+Bw35uJuDFG+iOchynPqw@mail.gmail.com>
Subject: Re: [PATCH net-next v1 3/4] tools/net/ynl: Extend array-nest for
 multi level nesting
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jacob Keller <jacob.e.keller@intel.com>, Jiri Pirko <jiri@resnulli.us>, 
	Stanislav Fomichev <sdf@google.com>, donald.hunter@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 3 Mar 2024 at 04:05, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Fri,  1 Mar 2024 17:14:30 +0000 Donald Hunter wrote:
> > The nlctrl family uses 2 levels of array nesting for policy attributes.
> > Add a 'nest-depth' property to genetlink-legacy and extend ynl to use
> > it.
>
> Hm, I'm 90% sure we don't need this... because nlctrl is basically what
> the legacy level was written for, initially. The spec itself wasn't
> sent, because the C codegen for it was quite painful. And the Python
> CLI was an afterthought.
>
> Could you describe what nesting you're trying to cover here?
> Isn't it a type-value?

I added it for getpolicy which is indexed by policy_idx and attr_idx.

./tools/net/ynl/cli.py \
    --spec Documentation/netlink/specs/nlctrl.yaml \
    --dump getpolicy --json '{"family-name": "nlctrl"}'
[{'family-id': 16, 'op-policy': [{3: {'do': 0, 'dump': 0}}]},
 {'family-id': 16, 'op-policy': [{0: {'dump': 1}}]},
 {'family-id': 16,
  'policy': [{0: [{1: {'max-value-u': 65535,
                       'min-value-u': 0,
                       'type': 'u16'}}]}]},
 {'family-id': 16,
  'policy': [{0: [{2: {'max-length': 15, 'type': 'nul-string'}}]}]},
 {'family-id': 16,
  'policy': [{1: [{1: {'max-value-u': 65535,
                       'min-value-u': 0,
                       'type': 'u16'}}]}]},
 {'family-id': 16,
  'policy': [{1: [{2: {'max-length': 15, 'type': 'nul-string'}}]}]},
 {'family-id': 16,
  'policy': [{1: [{10: {'max-value-u': 4294967295,
                        'min-value-u': 0,
                        'type': 'u32'}}]}]}]

> BTW we'll also need to deal with the C codegen situation somehow.
> Try making it work, if it's not a simple matter of fixing up the
> names to match the header - we can grep nlctrl out in the Makefile.

Yeah, I forgot to check codegen but saw the failures on patchwork. I
have fixed the names but still have a couple more things to fix.

BTW, this patchset was a step towards experimenting with removing the
hard-coded msg decoding in the Python library. Not so much for
genetlink families, more for the extack decoding so that I could add
policy attr decoding. Thinking about it some more, that might be
better done with a "core" spec that contains just extack-attrs and
policy-attrs because they don't belong to any single family - they're
kinda infrastructure for all families.

