Return-Path: <netdev+bounces-68597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4968475A2
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 18:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA00B286F9A
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 17:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00CB14E2D4;
	Fri,  2 Feb 2024 17:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvcUg+Vm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5A214A0B6
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 17:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706893404; cv=none; b=WepUbY+mtyyLGOpl4+NJps1zSvnJtLzT7LrYcRhs/LXRYzund/wbHUDuL4uD7IuX8OmV0dC5y3dRzgh1K/b9QSDGVSEylyIJL+omDDA2XOWL2Bt3KqdVdEC8m8WJOxwYFn8NJtX6zIb+Jvst02Q+nSncGJxBkBZNVvaZjVqLCH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706893404; c=relaxed/simple;
	bh=IxLL/0H0gGhd07FKs6WoO0NAwVO4dzhBaXT15xJtKho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KiBEB3GQMWdf0r9lDw0C5px4q4/jZXLjNwk74lJwxpLDQFhzWjpaxBgVg8gwamrjoKNxK2puz1tXNw+Dtp9hYfppBjw7vVFJKXuZye5Ps5gdfAYi5bmGm1NKEFKXLubTn0YSvqStjx6/pIAMMk80VLEBli2kZ9SNr/H0ese5hCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GvcUg+Vm; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6e1149c16d4so935241a34.3
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 09:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706893402; x=1707498202; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G85IrO6OsCYaMBt5phih3TaZjJeHQLeVvk2P9ws0Iaw=;
        b=GvcUg+Vm8cFf3ebGv81ncq61sNtuRq0oIlVE4VBhs69oCGoPNOpikwkCsRKDrxPVdL
         f9EN39wxovFsx6Ijd6MWX0UqlhL3hW4Gow9udtn0aMlsPvcmz7bt7X6RMgFtcRrjsPR5
         tE0XCdFdRxXBltGDLRHQTQfXA70t9B9klQ8nQBqa5AYDBA6XCNyvy14UjKgAMdYOfw4j
         o0Zn56Nold/fVh4PK12yFtWfPjoSqQbWfdTxa0OPd3Wrf8NcuciAAyngQOuewSFeG1yF
         /MLAr5sUfmAIsa6+bqdX7r+95kB22ll93Rj/52gMXHKOWZj2/z59RKlY7oXaS4cFYqQS
         DzUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706893402; x=1707498202;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G85IrO6OsCYaMBt5phih3TaZjJeHQLeVvk2P9ws0Iaw=;
        b=rkbN4wXk5WUuJ3TzgngNPIQzb558ePsbIOnASgLA0eV54ipmxVaibnT4t92iaLCsiG
         ai0nCZuUVQu9fN98RkQi3BZo6d/d/WPBbIMW+5Ba9qaRqf4YQbEDLPf+kX45IDQKEBJR
         ccj08PrphHxhnR1u6YNDxRVp8NAmoKelHGYK+4djQJuhpABZHpIt+FihFDY0dCv1SSOj
         HHbOziMJOg6vWOpo0zy85H9Byq9PEqyvrlN9d69YYdHZe4FhoIBwx/eRxeLosBQHA7B5
         3EZz0wEoT1FoTSq/zr6C93B9pOxkpiWg5ERW12kTpGNrZCW7qpyeVcl6Y028l9cSwxSX
         CSOQ==
X-Gm-Message-State: AOJu0YzJmKZKnTGqJuWLTztQ4yazJXfpsysiCaxKWOSqp3RYfbz+gNks
	etDhqPRJlO0zhlsaeOhVy0FWU/U4BWvIPLy3ccdjDeTTqWeBQwJMpmXrAoxO2MOJy/snLRauYac
	YxM0+9UyshO7+NuMUwoWPCb3+OTtDwSNgBmg=
X-Google-Smtp-Source: AGHT+IGKfQRs7MiFrLlw0S2xXjROZ+DzpQcQV8OJ6ltdIxMwoKZtZgLwAk3J2OuyitusbsDBvPQ/viwe3Vkqo8Ezdls=
X-Received: by 2002:a05:6870:71d0:b0:218:dc16:1d17 with SMTP id
 p16-20020a05687071d000b00218dc161d17mr323188oag.0.1706893401715; Fri, 02 Feb
 2024 09:03:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201034653.450138-1-stephen@networkplumber.org>
 <20240201034653.450138-2-stephen@networkplumber.org> <Zbtks__SZIgoDTaj@nanopsycho>
 <20240201090046.1b93bcbd@kernel.org> <m2bk8zulpb.fsf@gmail.com> <20240202082358.1f2fd8ec@kernel.org>
In-Reply-To: <20240202082358.1f2fd8ec@kernel.org>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Fri, 2 Feb 2024 17:03:10 +0000
Message-ID: <CAD4GDZwN7LayMwCS7aFx8sn4h0d_3N8ptyYa8Xe0oQAhzm-Ysg@mail.gmail.com>
Subject: Re: [PATCH 1/3] net/sched: netem: use extack
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 Feb 2024 at 16:24, Jakub Kicinski <kuba@kernel.org> wrote:
>
> That's fine, I was thinking opt-in. Add a bit to ops that says
> "init_requires_opts" or whatnot.
>
> > I'm in favour of qdisc specific extack messages.
>
> Most of them just say "$name requires options" in a more or less concise
> and more or less well spelled form :( Even if we don't want to depend
> purely on ATTR_MISS - extack messages support printf now, and we have
> the qdisc name in the ops (ops->id), so we can printf the same string
> in the core.

Fair point, it's not easy to steer people to the right options attrs.

> Just an idea, if you all prefer to keep things as they are, that's fine.
> But we've been sprinkling the damn string messages throughout TC for
> years now, and still they keep coming and still if you step one foot
> away from the most actively developed actions and classifiers, you're
> back in the 90s :(

So true. FWIW I was thinking of putting some effort into smoothing off
some of the sharp edges in all of the qdiscs, along the lines of this:

diff --git a/net/sched/sch_choke.c b/net/sched/sch_choke.c
index ae1da08e268f..8c16fcbaad71 100644
--- a/net/sched/sch_choke.c
+++ b/net/sched/sch_choke.c
@@ -352,19 +352,28 @@ static int choke_change(struct Qdisc *sch,
struct nlattr *opt,
        if (err < 0)
                return err;

-       if (tb[TCA_CHOKE_PARMS] == NULL ||
-           tb[TCA_CHOKE_STAB] == NULL)
+       if (tb[TCA_CHOKE_PARMS] == NULL) {
+               NL_SET_ERR_MSG(extack,
+                              "Missing TCA_CHOKE_PARMS of type
'struct tc_red_qopt'");
                return -EINVAL;
+       }
+       if (tb[TCA_CHOKE_STAB] == NULL) {
+               NL_SET_ERR_MSG(extack, "Missing TCA_CHOKE_STAB");
+               return -EINVAL;
+       }

        max_P = tb[TCA_CHOKE_MAX_P] ? nla_get_u32(tb[TCA_CHOKE_MAX_P]) : 0;

        ctl = nla_data(tb[TCA_CHOKE_PARMS]);
        stab = nla_data(tb[TCA_CHOKE_STAB]);
-       if (!red_check_params(ctl->qth_min, ctl->qth_max, ctl->Wlog,
ctl->Scell_log, stab))
+       if (!red_check_params(ctl->qth_min, ctl->qth_max, ctl->Wlog,
ctl->Scell_log, stab)) {
+               NL_SET_ERR_MSG(extack, "TCA_CHOKE_PARMS has invalid
red parameters");
                return -EINVAL;
-
-       if (ctl->limit > CHOKE_MAX_QUEUE)
+       }
+       if (ctl->limit > CHOKE_MAX_QUEUE) {
+               NL_SET_ERR_MSG(extack, "TCA_CHOKE_PARMS.limit exceeds
CHOKE_MAX_QUEUE");
                return -EINVAL;
+       }

        mask = roundup_pow_of_two(ctl->limit + 1) - 1;
        if (mask != q->tab_mask) {

