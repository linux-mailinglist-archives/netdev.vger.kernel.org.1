Return-Path: <netdev+bounces-56792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 796DD810DD1
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 11:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C4C0B20C0D
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 10:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9E521A11;
	Wed, 13 Dec 2023 10:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELko1NmK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E98FD0;
	Wed, 13 Dec 2023 02:03:37 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40c3ca9472dso46371305e9.2;
        Wed, 13 Dec 2023 02:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702461816; x=1703066616; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f8qqPzpX3NwhioKDxG+sr3PTetKA9MI6PcjmZfCUj4w=;
        b=ELko1NmKMoqq3AX79kzl6aDA3dnLkLuGu+Xc32v+KEGRvJKgZPJhq0FkRQsa+l49ua
         x0D+NJbqbmJHrnrXpYNBC+2WwIfdui5bxAK7QsCyN9M5hhQ0SvvA5WqPHDTVUXMVdZ5n
         ARnkNN0vMob3v1Vo9AXo1tw8yxgum/6N5E2jAVqqZ0hxpusVewcTrSHkOrd2ymUz3lYp
         hQAUZUM1ObMpoCKCWFPl43qNFZZhsNFGNrOT7ycmad07J7g8rp8rEe1sF9m7rvuI6Ihe
         xNgp7kVt6SbP4H68tCcliiWYhjwkhXDB2uDjjlagbVSdyORLp9ozvYy8ZoraFFmGdHK+
         fr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702461816; x=1703066616;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f8qqPzpX3NwhioKDxG+sr3PTetKA9MI6PcjmZfCUj4w=;
        b=VP5nPrckbqR/zxU31kR0JHH8CWHuhURaTRjvxSGN7NG8UHM0sQFBfeMSbpOfjZoZvL
         j6/c7kAzmzO2r8PR3+MWvp/xMlCtpoRUmL2/Q4VJzo2SW5cmCDKVIj3Ir/8UOHlwTHQ7
         7tu6ugm9EcryPykRpl7LMSvOtm1F9P2b5HtIfdLjYCsCJdmnE3ysjXsaNoRyBlbvLmpr
         U6WtaC8kQmmfS9QavNYnhYS//0rtSaPv/TtHNnuCdpiQ2t129FR/c9rzWkrkbp/BlgFl
         468d5GEy5tOY2rMpZhX7A4hmmnLz6XnS5WSJTi4TWOEgM/ctai46rOmh4FPR5AcjXDVw
         WYVg==
X-Gm-Message-State: AOJu0YzB1IBwdueXGmeMOkVhpPxovNXDErvjO8cKknXAFo7I02Idxnba
	zHHWWpfKuXdJfB5qoCKv8IA=
X-Google-Smtp-Source: AGHT+IEaHq/xbb7w5dk0fK0Ob0wSA3I9gvWPWTmkEuMomMeLNWr+5CuyK+IBgH1BjH+hTEVvLeI15Q==
X-Received: by 2002:a05:600c:4f41:b0:40c:3744:9bd9 with SMTP id m1-20020a05600c4f4100b0040c37449bd9mr2639704wmq.113.1702461815811;
        Wed, 13 Dec 2023 02:03:35 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:a1a0:2c27:44f7:b972])
        by smtp.gmail.com with ESMTPSA id m11-20020adfe94b000000b00333504001acsm12855584wrn.15.2023.12.13.02.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 02:03:34 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: netdev@vger.kernel.org,  Jakub Kicinski <kuba@kernel.org>,  "David S.
 Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Paolo
 Abeni <pabeni@redhat.com>,  Jonathan Corbet <corbet@lwn.net>,
  linux-doc@vger.kernel.org,  Jacob Keller <jacob.e.keller@intel.com>,
  donald.hunter@redhat.com
Subject: Re: [PATCH net-next v3 09/13] doc/netlink: Regenerate netlink .rst
 files if ynl-gen-rst changes
In-Reply-To: <ZXjuEUmXWRLMbj15@gmail.com> (Breno Leitao's message of "Tue, 12
	Dec 2023 15:34:41 -0800")
Date: Wed, 13 Dec 2023 09:42:52 +0000
Message-ID: <m21qbq780z.fsf@gmail.com>
References: <20231212221552.3622-1-donald.hunter@gmail.com>
	<20231212221552.3622-10-donald.hunter@gmail.com>
	<ZXjuEUmXWRLMbj15@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Breno Leitao <leitao@debian.org> writes:

>> +$(YNL_INDEX): $(YNL_RST_FILES) $(YNL_TOOL)
>> +	$(Q)$(YNL_TOOL) -o $@ -x
>
> Isn't $(YNL_INDEX) depending to $(YNL_TOOL) indirectly since it depends
> on $(YNL_RST_FILES) ?
>
> I mean, do you really need the line above?

Sure, the transitive dependency is sufficient. I tend to add an explicit
dependency for a script that gets run in a target.

Happy to remove that change and respin if you prefer?

