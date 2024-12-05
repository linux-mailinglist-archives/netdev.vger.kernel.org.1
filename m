Return-Path: <netdev+bounces-149237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA089E4D82
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 07:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD16A18813EF
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 06:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8021519340F;
	Thu,  5 Dec 2024 06:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b="DSjbZSg1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E0218D620
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 06:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733379119; cv=none; b=jG1pqO/U9MJSSkb43zU3KzttWxz/Zhf7V0uzFxjnCfhAL+NgMowDzjvNSzC7VlkKtzOdrYEkKK04ZzkJHCw4KHRePAG0VEIDkdOH8FPHrdC1UWFNc6fPVB+/bvztTpBKOb7uZktXjsV4rWCWfWe79KN9Ta8+tn0EtgMYKbAIy/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733379119; c=relaxed/simple;
	bh=N58mLh4R6Z5+56eqYXJOvP67fvUj+keXePDjXXk4/GA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yi735/GgjPI5I8FWUFRw3wpY8jqnfgEhC6tmRBytcEjbDt0j9zpTuxWaLpPD1nAK6mUjRf5wbEZEmB6zumWLnOYrLC6aWy29bAD+md/dMGJEgjRb3W0vBJ9XzHrRFJs9VF6vP7ZgCNFF66mO9Vk99PQNY2L75rA+eas8s8zG4ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com; spf=pass smtp.mailfrom=mvista.com; dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b=DSjbZSg1; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-288fa5ce8f0so190513fac.3
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 22:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1733379116; x=1733983916; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qeX/SVqRW2DoifmUtEk8X8kAw4AxGDp5w9WknffWQ80=;
        b=DSjbZSg1cuw5CONoyq9TS02/bitWqAjhVCrhfDaU9PUhvqZ3PhsZAKuFJpXrMVjwSL
         mdVEWr1OCqMwEGMTCDu3crsudD4gdyzQlN5oXll7MZxVgXErgPKl2hl4+NdIBM8crzCB
         S9OHiYfAHZr7Wn7Aq+04vUBXld7fy98OPe6zw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733379116; x=1733983916;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qeX/SVqRW2DoifmUtEk8X8kAw4AxGDp5w9WknffWQ80=;
        b=oimJUQ4vfHnFMF0094slwNvFbmsnslpbDMuJH2r68UeKMa2yWSdbQcDbuhai49gMbk
         DzVRZSXB95hdYfaayIyo0Yaq/WRbMQ2oEb29RvI8gRNCUkbEjNoDUA5VnPN02paV8lB7
         V2v1bPIOrS99l0KXjtzHZdjg3tC7WI4asjqUtnHcgffL4AYTBO6m1ZeFUbjqf73MxdJj
         ddaEsZS+FXZA4F6tR5QFpGoXd06aVAE7pmyhTYcVhpn9lK4LP9bb3dX34Xdiv3E3zDRj
         1NEzzrEJ3qf/vtninfbThXIOWYKP2MOA5cNsEN1W14VB+M+u8xIDpbIPj9Mi2KL24XGx
         xHVQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8ArPlqWdtRnnwGfVEahM85dUrLs7AArrnRbmezh2BwTLNWfNbEgWCAIslOxL7qhGokTkLQZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGCcIcK/qTQCYGIiXHxQepMcHaq9zspFT9ynbtw6rbOX9XjXJ5
	JGwge7VqrS31iJyJCZ8dYd5v0iEkjPWivF3nZALJ06AtC37GdaYGcK2QhOitl+w731ZTNAkiyr1
	7i9PKQUrtsYLYbZDCxnUWaH5uAi4zKB6osC0PSg==
X-Gm-Gg: ASbGncvSJXPQTA7B821jeh/GuLw0Dqu1pR7dFWuI/0/6RRfpTLQP/CfbE4flWD1SyWE
	222/3YmfWwEhSxFFWkWkmOHlWPk41XCY=
X-Google-Smtp-Source: AGHT+IF4cHRWOhpU9TlTUHM2cx/gC4+Nv9f+vVihql/WAkuwTumEVreP3K5qXNM2FuWgtEehQIE0VugjW0quHeZeMEs=
X-Received: by 2002:a05:6870:b07:b0:297:27b5:4d30 with SMTP id
 586e51a60fabf-29e885ed433mr8952464fac.2.1733379116649; Wed, 04 Dec 2024
 22:11:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1729316200-15234-1-git-send-email-hgohil@mvista.com>
 <2024102147-paralyses-roast-0cec@gregkh> <CAH+zgeGXXQOqg5aZnvCXfBhd4ONG25oGoukYJL5-uHYJAo11gQ@mail.gmail.com>
 <2024110634-reformed-frightful-990d@gregkh>
In-Reply-To: <2024110634-reformed-frightful-990d@gregkh>
From: Hardik Gohil <hgohil@mvista.com>
Date: Thu, 5 Dec 2024 11:41:45 +0530
Message-ID: <CAH+zgeGs7Tk+3sP=Bn4=11i5pH3xjZquy-x1ykTXMBE8HcOtew@mail.gmail.com>
Subject: Re: [PATCH v5.10.y v5.4.y] wifi: mac80211: Avoid address calculations
 via out of bounds array indexing
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, netdev@vger.kernel.org, 
	Kenton Groombridge <concord@gentoo.org>, Kees Cook <kees@kernel.org>, 
	Johannes Berg <johannes.berg@intel.com>, Xiangyu Chen <xiangyu.chen@windriver.com>, 
	Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Kenton Groombridge <concord@gentoo.org>

[ Upstream commit 2663d0462eb32ae7c9b035300ab6b1523886c718 ]

req->n_channels must be set before req->channels[] can be used.

This patch fixes one of the issues encountered in [1].

[   83.964255] UBSAN: array-index-out-of-bounds in net/mac80211/scan.c:364:4
[   83.964258] index 0 is out of range for type 'struct ieee80211_channel *[]'
[...]
[   83.964264] Call Trace:
[   83.964267]  <TASK>
[   83.964269]  dump_stack_lvl+0x3f/0xc0
[   83.964274]  __ubsan_handle_out_of_bounds+0xec/0x110
[   83.964278]  ieee80211_prep_hw_scan+0x2db/0x4b0
[   83.964281]  __ieee80211_start_scan+0x601/0x990
[   83.964291]  nl80211_trigger_scan+0x874/0x980
[   83.964295]  genl_family_rcv_msg_doit+0xe8/0x160
[   83.964298]  genl_rcv_msg+0x240/0x270
[...]

[1] https://bugzilla.kernel.org/show_bug.cgi?id=218810

Co-authored-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kees Cook <kees@kernel.org>
Signed-off-by: Kenton Groombridge <concord@gentoo.org>
Link: https://msgid.link/20240605152218.236061-1-concord@gentoo.org
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
[Xiangyu: Modified to apply on 6.1.y and 6.6.y]
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Hardik Gohil <hgohil@mvista.com>
---
 net/mac80211/scan.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index be5d02c..bcbbb9f 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -351,7 +351,8 @@ static bool ieee80211_prep_hw_scan(struct
ieee80211_sub_if_data *sdata)
  struct cfg80211_scan_request *req;
  struct cfg80211_chan_def chandef;
  u8 bands_used = 0;
- int i, ielen, n_chans;
+ int i, ielen;
+ u32 *n_chans;
  u32 flags = 0;

  req = rcu_dereference_protected(local->scan_req,
@@ -361,34 +362,34 @@ static bool ieee80211_prep_hw_scan(struct
ieee80211_sub_if_data *sdata)
  return false;

  if (ieee80211_hw_check(&local->hw, SINGLE_SCAN_ON_ALL_BANDS)) {
+ local->hw_scan_req->req.n_channels = req->n_channels;
+
  for (i = 0; i < req->n_channels; i++) {
  local->hw_scan_req->req.channels[i] = req->channels[i];
  bands_used |= BIT(req->channels[i]->band);
  }
-
- n_chans = req->n_channels;
  } else {
  do {
  if (local->hw_scan_band == NUM_NL80211_BANDS)
  return false;

- n_chans = 0;
+ n_chans = &local->hw_scan_req->req.n_channels;
+ *n_chans = 0;

  for (i = 0; i < req->n_channels; i++) {
  if (req->channels[i]->band !=
     local->hw_scan_band)
  continue;
- local->hw_scan_req->req.channels[n_chans] =
+ local->hw_scan_req->req.channels[(*n_chans)++] =
  req->channels[i];
- n_chans++;
+
  bands_used |= BIT(req->channels[i]->band);
  }

  local->hw_scan_band++;
- } while (!n_chans);
+ } while (!*n_chans);
  }

- local->hw_scan_req->req.n_channels = n_chans;
  ieee80211_prepare_scan_chandef(&chandef, req->scan_width);

  if (req->flags & NL80211_SCAN_FLAG_MIN_PREQ_CONTENT)
-- 
2.7.4

