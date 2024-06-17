Return-Path: <netdev+bounces-103956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB47D90A857
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 10:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B03D281187
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 08:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61BA190496;
	Mon, 17 Jun 2024 08:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oy/L59JV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C684190065;
	Mon, 17 Jun 2024 08:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718612727; cv=none; b=drHK1V7olRLk/XpLcjOdOHu9Ni5ixXbQyV3YryxikOAkv80TTThJS43GKn5z2hNsDvN/jlBpb2W2R1bI+BjLpo6kAHWbQCmZowOFGQTELXfyZqA+enP05NHeOo4lsqgojzqEmReTKrBA8hIzHAJhL8ClFtI9Wr2CGz1SsZ7L4/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718612727; c=relaxed/simple;
	bh=hmU824QnrpC0lK8tVDT8fdNpMyBHMWTrn1YpJc23BPE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=MujeHoJHvsSC4sbWpQvWOaPZYNJn+aIwsPjqHD8nHWr6Kgrgn1u+eqH5XqrQ5HJKGcL6B+RCFaLUXq03m3L8N0QMK/aV8iM3T0pjz+nhby8cezHUgPhFaNb0E38Bm9OUhg3F5nGQGXl+ciTIq0FNBvK/6i3fevsIGe8Of5/0bbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oy/L59JV; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-36084187525so1817666f8f.3;
        Mon, 17 Jun 2024 01:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718612724; x=1719217524; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6hI9+1uTx3Adx5p6ccWgkTX1YKY9U2jSF8968/Euis=;
        b=Oy/L59JVC15/xv6nwNIocrhyFxIuEGJVh5FlqrKDN5pZE2riUx1FxMBb+g9yvHtsb2
         j44r/hiZXpmsRqA/pyp3XWDgmPIqdTjG56kdgtlY8jHaStE6PFKLXTyEq74wmpgAQdF1
         xyiZdAo3h0FtlP9gqC6YIMCLCpG5/ZpwnQ/XFPdtIjlAgr8ta2BD/S63wca4PWwePYbw
         cV2WgeUwNVmzuPGWtxYsMZExfko6Lw81942+I6jSLykxOhQ71ZvBMtkMoSN8zK5ejwGl
         JeNSo0uiTmIa572+1IUyhCOmfo/tNE+fDJSnriyO8OixYTZDlUOrL5AIjM+WnL24vR4w
         x4RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718612724; x=1719217524;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6hI9+1uTx3Adx5p6ccWgkTX1YKY9U2jSF8968/Euis=;
        b=R5gGaIfHJVaWNpvW+f5R2RzUjEsz1KiDdsX493A25gVvBT58ygbAl0KstGXmTMh814
         yn3F6dXhxABa6CGhlEI5r1gVvQHRj+FINibNkjmF7Wj5pI35Gyo+7wKJkuWGTLcoZxyl
         0toBwsuEHC1qw7OoWYykgDZOZb48k9jsvdD6REWE69c8zHVabVAT4o/Z3kQiPEPNqMdc
         2nV16cjycJMjGJWzF9fg2U5mIrmswNKsMtedx247SdZ4dVuT5lhBxXpKUXTPYZ/7MXWP
         oL9uHGNBrEUFl6G3rV4v8mFWyVGO2dggELRLPP34qW8KY340MgXnANnKiGWklr+zbgnm
         flCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbOfzEOBWaZHOcODmQGu29K1e2wBNwJIf2M1c2jq9YuWBKSJ4FkugCLZlHT5fDdT/h+/rBv2JPfZN8AoRoDKTN4/UufHIJFLKvw9Z9aPHnmLQ9Kyah52YB/XdvcZ0b5rTYXuXX
X-Gm-Message-State: AOJu0YwT9t6dFa9T9AFwR2ByiWNqteaZnGV5cYMEIpgsDsnAvW6uhscV
	IMO46cdXuZ1NjzDd882ZJR87hTQl4BUbGhVYpkBiuS50mvr8kwWD
X-Google-Smtp-Source: AGHT+IFY0ksGLwooQAFy/3i5wjbx3UniG7SqfJG9ahS+JaxSO5a3g646TRVNAKR/k1cp06ES7HP1CQ==
X-Received: by 2002:adf:f247:0:b0:360:6dc8:46c0 with SMTP id ffacd0b85a97d-3607a764d88mr5927789f8f.25.1718612724308;
        Mon, 17 Jun 2024 01:25:24 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:9594:d2ff:a13c:2a33])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750ad082sm11212712f8f.59.2024.06.17.01.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 01:25:23 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Oleksij Rempel <o.rempel@pengutronix.de>,  Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>,  linux-kernel@vger.kernel.org,
  netdev@vger.kernel.org,  Dent Project <dentproject@linuxfoundation.org>,
  kernel@pengutronix.de
Subject: Re: [PATCH net-next v3 6/7] netlink: specs: Expand the PSE netlink
 command with C33 pw-limit attributes
In-Reply-To: <20240614-feature_poe_power_cap-v3-6-a26784e78311@bootlin.com>
	(Kory Maincent's message of "Fri, 14 Jun 2024 16:33:22 +0200")
Date: Mon, 17 Jun 2024 09:03:12 +0100
Message-ID: <m2bk409etb.fsf@gmail.com>
References: <20240614-feature_poe_power_cap-v3-0-a26784e78311@bootlin.com>
	<20240614-feature_poe_power_cap-v3-6-a26784e78311@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kory Maincent <kory.maincent@bootlin.com> writes:

> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
>
> Expand the c33 PSE attributes with power limit to be able to set and get
> the PSE Power Interface power limit.
>
> ./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do pse-get
>              --json '{"header":{"dev-name":"eth2"}}'
> {'c33-pse-actual-pw': 1700,
>  'c33-pse-admin-state': 3,
>  'c33-pse-pw-class': 4,
>  'c33-pse-pw-d-status': 4,
>  'c33-pse-pw-limit': 90000,
>  'header': {'dev-index': 6, 'dev-name': 'eth2'}}
>
> ./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do pse-set
>              --json '{"header":{"dev-name":"eth2"},
>                       "c33-pse-pw-limit":19000}'
> None
>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

