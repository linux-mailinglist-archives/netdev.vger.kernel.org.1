Return-Path: <netdev+bounces-191502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75ED1ABBAE6
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 12:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A3593A7BD2
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 10:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40AA26C3A3;
	Mon, 19 May 2025 10:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7/A0Nel"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288841DE3C7
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 10:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747649966; cv=none; b=RFGQrOOZ561+qSCOCHzr0xXgR5Qm3lTMinbDFLMtKijPdXWSq9v/2bgLhoTSd7EJ39IGNQEgH2ghbkzyKvHY0siox8A9AewWR5Gw7Ri59PWpLS5jb3+Vs+UGjmRdJVBOr7b+cpU98I55RuEB7w7cJ2Ykx+E0UI6cfu5cQ4A6g+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747649966; c=relaxed/simple;
	bh=9NS/sQkJv/2TlvkpdRucZtq54th5bwBuD1ncjG1IkqI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=kZ+isgORYImF0otf1JQnBKWdf7bwk0G58ZSbqegsSUX71rlkuF2P1uYoO0tz6xzIsj5sXAgg+9o9sLu1SWM1G8eymTk88H7uy4dbcchFbLVn89/2SODQB0EsrgO4BnHokRs3cIzJHvjy9sUHSFt7lG2J9VIu6S7nDUERArT4jqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7/A0Nel; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-441d437cfaaso24537535e9.1
        for <netdev@vger.kernel.org>; Mon, 19 May 2025 03:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747649963; x=1748254763; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9NS/sQkJv/2TlvkpdRucZtq54th5bwBuD1ncjG1IkqI=;
        b=f7/A0NelluTi69eMfBJ8JWv7mRZuF4U8LvYZSO4uLuXzSLlUiIJokK/EzvE0mB5zcL
         uzHU84FZkwzrvJjOTDaSkdAjZ07Kpcrg7LQq1tvb8BdEHBPiX3q6bUwxLjA8j/UAY+2g
         cszfLgBUeWFMDGxICkywhDj28gC3F2BApeaSUHyc5MUgxUxa75hMMsIrJHk31JKoYs52
         fFota96QdXW7YRERIfPO8SpIcYFqBGxC+uDZ9OyNc/9KUn/IgzRQ/5pslLN8VuaF9yDp
         8QmRrL/dAlo+/T8xwle93LtAabd9jzniXSgWIbGcxvFHM58SnaOXzhj30/hGB9+S+HtE
         wTBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747649963; x=1748254763;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9NS/sQkJv/2TlvkpdRucZtq54th5bwBuD1ncjG1IkqI=;
        b=CMX3aSMLKV0srio2TWlYDiGcp+tBHEqNwS3W0moKXr8qgFtxEi6Y2HqMN++wo2HQyo
         Kc7OIBusia4s+UW0agy1tl7Iz76ng2IgYPm7bzvRvMyCHlpNA6PL0qA3cBAasQIg5Ykv
         tx2F8LqKMd6RDb92MGPEt2fdQ9R+lhKSHwLkjIA/D5oxAjuHjjqkIt6CnVSg8Y7ny82M
         SvbG4Avv7lC3pFmeItT+WigskznlI9OwQ/gO2z0NqwWSYePQ2k2UbtWQdiXC9fqwrWcd
         APqNrdLaM/WkbsJq2DpmFRjBjp3eyHZRM0BXi0f3hIR+eNFASiAgOu7nn6N3MXWO+Dc7
         Fcgg==
X-Forwarded-Encrypted: i=1; AJvYcCX/cMJFgWMGPmK7ZOe3LJCOfEvQoMQkYlbxSufw1pyril4yWO5JQ61JnfvBEPD4Uj+9I31I2VY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEDhC61RFxiFVHU5TEvLNJgwTA3cQuiOjldQgZ2oyGgD047etF
	vDx7zOIm9VZFO/qi47tviKP1dQwgBmPbeCcyWPqbk//fRINUrQ5K61wX
X-Gm-Gg: ASbGncuv/eQJv5arx3zrMDcSkiz6cHE2LoU/NSkfvRnYb5r1bvh7GomlTxtgB0tecjJ
	Xi1JJP6x1yLzeLh7SYt4EW0E9mFMkqjhK+TEt8O5TSPYCy6RZIAQJrqjxIQtABRbltwZ3/98smc
	HBh6HxkZafaKOHCrzqjrqOz2gqajNsJphjGwDW3L7YUL7DIfams2z/n8HjUtYw+3TG/NDWBbZDW
	rCet9VhT57/s/wosYjj6LXBuSRqhtIuCvKaDLxjbjBbQy+kjL2rOOI01BwdOzG48JXDIUW6kWz1
	oIZQsfdNtkTL6QUX/pzicti9sVSc2uxzPV2oKy3jfo4eorA+GHrNbKZnoEyRFyiTAxgrPJahY6I
	=
X-Google-Smtp-Source: AGHT+IEgxikoRCOtMd1MuN7phNkbs5jpmuFVQc2xSjIsLad69FdlzeevvTO7pLlytwXH4SUDGx2OFA==
X-Received: by 2002:a05:600c:3c82:b0:43c:fffc:7886 with SMTP id 5b1f17b1804b1-445229b431cmr42646975e9.8.1747649963123;
        Mon, 19 May 2025 03:19:23 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:d5e9:e348:9b63:abf5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442fd50ee03sm132437905e9.14.2025.05.19.03.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 03:19:22 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  jacob.e.keller@intel.com,  sdf@fomichev.me,  jstancek@redhat.com
Subject: Re: [PATCH net-next 01/11] netlink: specs: tc: remove duplicate nests
In-Reply-To: <20250517001318.285800-2-kuba@kernel.org> (Jakub Kicinski's
	message of "Fri, 16 May 2025 17:13:08 -0700")
Date: Sun, 18 May 2025 14:34:11 +0100
Message-ID: <m2a57akppo.fsf@gmail.com>
References: <20250517001318.285800-1-kuba@kernel.org>
	<20250517001318.285800-2-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> tc-act-stats-attrs and tca-stats-attrs are almost identical.
> The only difference is that the latter has sub-message decoding
> for app, rather than declaring it as a binary attr.
>
> tc-act-police-attrs and tc-police-attrs are identical but for
> the TODO annotations.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

