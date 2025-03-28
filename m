Return-Path: <netdev+bounces-178145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F8FA74E75
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 17:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F0E43BA1A1
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 16:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969011D88CA;
	Fri, 28 Mar 2025 16:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlW8r0Fk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A1F17BD9;
	Fri, 28 Mar 2025 16:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743178682; cv=none; b=CQJjq2b6HWxMdSb7E0rrVGX/Uu6jHDPb2o8E52ThYEsnOnNRzfv5n38QYKqCnJ5DA+HeV9h/R0QFv/Gz1JRSCQCNnNhnuwiMy9FjNta6IIEG8KpfnDE3wXWGhMIslsoZGdwcrIn4XLpdHuW3sFp3fWhYe+YGgMla709yImulM3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743178682; c=relaxed/simple;
	bh=7qssfR41+fRhRzI4Egm/PD4wIN5YwI6NxzZdxmime6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VSdbbFef69E73CfNxJoAgdMbyKD+890a6WGpSPxBizzNDiCmmk4Ws5WKrLTFnq0qWoYAxCvflorVJk6MsHap9NsF9p1xAGG8XzNH+51EISuz/9tmf6SzHBXyP4QL956VoedPcGCwocsIZLm7oRuAjGMgPmxLm3vtW9CkTULeBh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IlW8r0Fk; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e455bf1f4d3so1961946276.2;
        Fri, 28 Mar 2025 09:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743178680; x=1743783480; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7qssfR41+fRhRzI4Egm/PD4wIN5YwI6NxzZdxmime6A=;
        b=IlW8r0FkQmI9lZitjWd5r+8IMeH2O5rRWGdGC5U1JX+aGhrsWSTcvj7YQq1bfY4d0F
         FFI3LwCNH14t6ndrH45bIyMLHMgRkUJWbK0oJEqS/XEzhmYloLESDYOdA9d7QL4aZbnb
         UO1O7pTPfYavB3HcPfaZ4ASBOAIjF0vvOMg1K5VNlBDCt39+A4EMgmBPFzVyrMThVFZR
         NU+ZwcmRJZ0sQDAafV9kIbOO3FbI6vvnWuijfJK+swGLDcTlS6Bjv4BnFLPO2SK9uH2u
         EeBaUmcBLFkXOv+RISSuZqYO2dgBx24ABcV9fPUwbhUrSSEvnbyI6hM6M/piMct41zax
         fTCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743178680; x=1743783480;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7qssfR41+fRhRzI4Egm/PD4wIN5YwI6NxzZdxmime6A=;
        b=Nz7nUrBflkxGeIla1NV3mVQcHltLYDeY/unvOq+NQEUZYFpAxKT3MIfvcC9ECZo332
         /VTxLUP+oCUNXIZ/hYouRQ3QSuMiPFuXDJi7gB+mWMqTGmmI6RzdTaScJD3Chpz6VA3Z
         PjQz3ozelLZU7bvsi2IYJfUkzCCG4+zUCcvjZe0XadKlfJZx8Hb5DYDp/0hYax6z2A8n
         Z69PCL+/j06sfzOE+yG55wAnPPD9BlC2LKOqaJpXq45cUWgMMsY+/Gm6ofnWuf3EAKd1
         Ay2lYTazzmhIVvJmdyAXtmfNuDmlr6LojRhSupkvCUONx6NsJZ8et8oZBS9oOcHT9Ixd
         3kBQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3Wi5alXoBj1NkNTXHdxTR5uDnrkgmlfNXK1Vn0FI6xgVhove5SKpTw9WHN2xtDZRzAyPzhwmS@vger.kernel.org, AJvYcCXz201Kz3kYmx2uTilsmwc6wE3AjYjyTWfKU0WrxIH0PEKGUA5TxZq5HLp+U9LdgHs+buzC4LY/WjxzaTs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw650XNcQvexjYRHbtCntYK8OdhBxLQnE1v77Gp4phqfVN4/ixN
	maUIaZslZXsyugLrYJxr3wQwG1OLNFTfuhnzBeO+dwoLLPGXaA9sZKZpHkp14qFt7bcitn5Hx/x
	yZHd8axmXv+y8H4c4Uf+GJOnNhA==
X-Gm-Gg: ASbGncv6U/pVrpvSNpU7wjjgDoBZIIAq024/YP8kn9zLUYl6qffVlkJc5oJ7K9dIr8M
	BCFIlpsYCLTmpdGOmTNhI+CR+/QSpQ8hLvymIHzejh53XPq4ukUFQ4ChOJy1pjTrry6KvfRe15A
	ysRzggHq+/58Q0KwYNYQ1wOSRDtPE1SkXgZ8Z+kBswc6sG0onY
X-Google-Smtp-Source: AGHT+IGN9dsDBzOvJPjL9CD4pSBzKWnHRy/a47xnHG8LXpRh7feIEt+c9x5mBhRHfqeb7a6JUKSU8hmPgkFhnclEYwU=
X-Received: by 2002:a05:6902:1a44:b0:e6b:808c:5fef with SMTP id
 3f1490d57ef6-e6b808c7f77mr1002214276.32.1743178679659; Fri, 28 Mar 2025
 09:17:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313093615.8037-1-rsalvaterra@gmail.com> <2710245b-5c2d-4c1f-93ef-937788c3c21b@intel.com>
 <CALjTZvZYFEqSGZvSfthsTC5sOkVixAFyPg0Jj7eXZ0tac4QS8w@mail.gmail.com> <024fb8ce-adb1-42f8-91f9-ef08868fee01@intel.com>
In-Reply-To: <024fb8ce-adb1-42f8-91f9-ef08868fee01@intel.com>
From: Rui Salvaterra <rsalvaterra@gmail.com>
Date: Fri, 28 Mar 2025 16:17:49 +0000
X-Gm-Features: AQ5f1JrApo2YnGDkBXpLnZjbWGXS9Ln2yMcMwJBPiJewh-yxz3hSbyyeIbLzIjY
Message-ID: <CALjTZvbChDaMACCdmubV9hVXWnih2Rx0NRkcj3K_NbW+O-qrbA@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] igc: enable HW vlan tag
 insertion/stripping by default
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Mor Bar-Gabay <morx.bar.gabay@intel.com>, przemyslaw.kitszel@intel.com, 
	edumazet@google.com, kuba@kernel.org, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi again, Tony,

On Fri, 28 Mar 2025 at 15:52, Tony Nguyen <anthony.l.nguyen@intel.com> wrote:
>
> Yes, it will be submitted for 6.16.
>
> Also, please don't top post :)

I almost never do, sorry about that. :)
Would it be too much to ask for this to be backported to stable,
though? I've tested it on the 6.6 and 6.12 series just fine.

Kind regards,
Rui Salvaterra

