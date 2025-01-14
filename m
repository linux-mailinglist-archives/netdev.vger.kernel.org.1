Return-Path: <netdev+bounces-158094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DCEA10726
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 13:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 373FF3A70F1
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 12:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A963229617;
	Tue, 14 Jan 2025 12:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aY7wqAB0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4527F236A7D;
	Tue, 14 Jan 2025 12:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736859341; cv=none; b=dT5TmteTNkuVclun7CUpJ35KzIjykh/GR8NXqXVrIq1iktNQR0TWVbTUw5fDlrip9v8Mzf20jTXtL5Gidx5VdEq89GJBKNIb6cDNM6aZLe5TRtYLhOAFwByn7dGKsLz/wazXhSE8/QfNE/6h6ogEIW8hj7PeT91RArfwk5/UroA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736859341; c=relaxed/simple;
	bh=aziq3tGeMnC/lFT/6W1ywa8GcHBSXbntgIKOhu82wjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRbBok+CsZXCQWs9iVgJ05JzUDSyOd2gqsGcSp2vPxosl52VrpU+S/fBYnXNv/TTdQ2g56wGs5Df0KJF4tOTHlfVlydDDzTKKzK0r2JhZOuGjo1S+OwFWDyZchxyMhKm0iDPlteAe54/nwMQ3Ep95FGs6j5420O6RZo2zOf/YHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aY7wqAB0; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3003e203acaso40807671fa.1;
        Tue, 14 Jan 2025 04:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736859337; x=1737464137; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h9NN6UgHpubwg3qk2UraoBU368Giq5y1/F299o0Pg1M=;
        b=aY7wqAB0tY2xBWkRX8jWW0KLaSQhu8hKOc3Fx3JSiFHwAsdR/v1tCqPIoceG5QEizt
         r+MnVM48Cqg6E69myO0IbvVew8/MwtC3LCazCB5sOZWnTRqGUwNFmWW+HY46PnG7IH1Q
         JfPbZ6fzNw5o2lUUODbas/C+9RCGVYKeZhggYCrvA0L+c5/Gu5afLrCtm4X3GGw6xXLX
         tGFqznynagr/dUE23VWiYC/o7XwSuZ3CV2EbDEH46E2FKVm+5uRz74aJx4Vmc8IJ4ZpG
         1TAvMfuth6aWHLXpeEIaZIDBOz1tGnOMXbfzo9d0hZvb4qyEvKU470EZ17kgbcgqYtKt
         ooNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736859337; x=1737464137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h9NN6UgHpubwg3qk2UraoBU368Giq5y1/F299o0Pg1M=;
        b=aAvpdOxSH9lYPjXk8PCsITMcQW7LmpFFB0vC1HtmITv9BAT6UNFOLEZUYnMR3Wr4Q8
         jUJ7D/Nz6FxjP4yDNJc+yq9xAy2+W5/grchlsiW93Fdr0jjOJMEBcDtQoNumY0uSqXNz
         wG07X+FCUiQJ2VyVhAva6+YmEaL9SqBd7MdAD8kvQSE26ek4hTVgVeZEhQBKBrERrm5W
         QXSHgOLSbn9n3OTf7P/zQLpczl43XcDzIntCn4fKpr92Zh6xJMHOBU0WKpODIh/fRR8e
         fWM5ZN5VqfqlrxmLMZXPx81kw7eLUTRI2H03GjQ4LUU58ShSRzQN1kYueCjS6Ty43cEr
         rExA==
X-Forwarded-Encrypted: i=1; AJvYcCUIpZl3ltJ/tMpeKZZYeu1AmJ1RYJ2MIppyxphHPGeEll2VFA5KIKv9tABjTUz8gMUULtvN8ENavuxMwoU=@vger.kernel.org, AJvYcCWkh9B8stNM+tl1T9MJSwChxcapxROqHMkViQLPvElZFFrzH9IXiKRhatxulYLs4+mRloVWP4Au@vger.kernel.org
X-Gm-Message-State: AOJu0YzMY6K/1tbbKwv2VevBLFXgjEkKGk7rPdRywbN9OrmhWw1ouOEz
	7xy+FCW2/FJZ5BTQz8ChCHJBXcjhHm569i1Orl4trWQvw1zmvpjd
X-Gm-Gg: ASbGncsacYAxK89IT4bayS1pdmgmFJ6dR5NrR82bhDC0QvnKzMo1B95iTKIaoGX0ThS
	oRn6z2tM1ySIt65uEayZRbo2yPAB0jISpxpE9J8WrclleBU9xprbTMmPkIcMBfx7DIZu2kvZrL/
	c5UqOpBPRmYZmI6C97y/aBMOcPhGh1iIgqpTwz97tmrufUN1ty7A1ysDFyNrhr3L762OkGIRy4k
	eCryNBPnaRROntBQVI0UlKEdN/FsFj84luGrDPX4GSOLJ6Skvyaiq6CQljq57wKt4E55C8=
X-Google-Smtp-Source: AGHT+IG2/7qNM4Nx8hRGfHkpD3zBM2aZUJ5pchsEvPYLlc+LJFgTSui1/j8kzbfJB3OnHwIayIZTdg==
X-Received: by 2002:a2e:be8e:0:b0:302:2a23:cf6 with SMTP id 38308e7fff4ca-305f45b1edemr77547191fa.12.1736859337032;
        Tue, 14 Jan 2025 04:55:37 -0800 (PST)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-305ff0f8a86sm17230191fa.63.2025.01.14.04.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 04:55:36 -0800 (PST)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
	by home.paul.comp (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 50ECtXus027558;
	Tue, 14 Jan 2025 15:55:34 +0300
Received: (from paul@localhost)
	by home.paul.comp (8.15.2/8.15.2/Submit) id 50ECtUK8027557;
	Tue, 14 Jan 2025 15:55:30 +0300
Date: Tue, 14 Jan 2025 15:55:30 +0300
From: Paul Fertser <fercerpav@gmail.com>
To: Potin Lai <potin.lai.pt@gmail.com>
Cc: Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Ivan Mikhaylov <fr0st61te@gmail.com>,
        Patrick Williams <patrick@stwcx.xyz>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Cosmo Chou <cosmo.chou@quantatw.com>,
        Potin Lai <potin.lai@quantatw.com>, Cosmo Chou <chou.cosmo@gmail.com>
Subject: Re: [PATCH v3 2/2] net/ncsi: fix state race during channel probe
 completion
Message-ID: <Z4ZewoBHkHyNuXT5@home.paul.comp>
References: <20250113-fix-ncsi-mac-v3-0-564c8277eb1d@gmail.com>
 <20250113-fix-ncsi-mac-v3-2-564c8277eb1d@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113-fix-ncsi-mac-v3-2-564c8277eb1d@gmail.com>

Hello,

On Mon, Jan 13, 2025 at 10:34:48AM +0800, Potin Lai wrote:
> During channel probing, the last NCSI_PKT_CMD_DP command can trigger
> an unnecessary schedule_work() via ncsi_free_request(). We observed
> that subsequent config states were triggered before the scheduled
> work completed, causing potential state handling issues.

Please let's not make this whole NC-SI story even less comprehensible
than it already is. From this commit message I was unable to
understand what exactly is racing with what and under which
conditions. "Can trigger" would imply that it does not always trigger
that wrong state transition but that would also mean there's a set of
conditions that is necessary for bug to happen.

> Fix this by clearing req_flags when processing the last package.

After reading the code for a few hours I can probably see how lack of
proper processing of the response to the last "Package Deselect" call
can mix up the states.

How about this diff instead (tested on Tioga Pass but there we didn't
have any issues in the first place)?

diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index bf276eaf9330..7891a537bddd 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -1385,6 +1385,12 @@ static void ncsi_probe_channel(struct ncsi_dev_priv *ndp)
 		nd->state = ncsi_dev_state_probe_package;
 		break;
 	case ncsi_dev_state_probe_package:
+		if (ndp->package_probe_id >= 8) {
+			/* Last package probed, finishing */
+			ndp->flags |= NCSI_DEV_PROBED;
+			break;
+		}
+
 		ndp->pending_req_num = 1;
 
 		nca.type = NCSI_PKT_CMD_SP;
@@ -1501,13 +1507,8 @@ static void ncsi_probe_channel(struct ncsi_dev_priv *ndp)
 		if (ret)
 			goto error;
 
-		/* Probe next package */
+		/* Probe next package after receiving response */
 		ndp->package_probe_id++;
-		if (ndp->package_probe_id >= 8) {
-			/* Probe finished */
-			ndp->flags |= NCSI_DEV_PROBED;
-			break;
-		}
 		nd->state = ncsi_dev_state_probe_package;
 		ndp->active_package = NULL;
 		break;

-- 
Be free, use free (http://www.gnu.org/philosophy/free-sw.html) software!
mailto:fercerpav@gmail.com

