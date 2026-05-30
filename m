Return-Path: <netdev+bounces-293341-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sC9dCeDFGmpw8QgAu9opvQ
	(envelope-from <netdev+bounces-293341-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 13:11:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C229060C63C
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 13:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 410FF301D035
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 11:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635393A9852;
	Sat, 30 May 2026 11:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAm/6E3A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF22B2EF64F
	for <netdev@vger.kernel.org>; Sat, 30 May 2026 11:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780139481; cv=pass; b=MmoWaNVNENnME1/QCHWzPitqPkuTv9fNJyoedplQheqWSZ/a6iaQca7noN2FMRhssOrp+tgVOm2W4TjYVT0SPo94aE88GwA3sy8bhNRl9kz3kjAXc8XVh8JODZoPp9ns13o7jmCANzV3EAUirl2aME0Ld+Sm4LuHIhCzHlyAAaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780139481; c=relaxed/simple;
	bh=5W2aE3S05lfZxC+0l9e2zIWzh1sbqU2nXGr4m5mTLJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JY8uIr8EVnQmRVTxPcFrkFdfpQoPsgOX+oglR78x6iURdTVC0NjiPy1i/VMMHdVmKoTyxmiEQRnWd53deX79tsIC9p99LApF1DL+a6s58tXI+s0qTnjWRsfMhxHcSvxVNB5Onw/vNBOGsxP7PGh9zhYxhTEKYwXwCAs8oFF45z8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WAm/6E3A; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-67c9616b4feso22783544a12.1
        for <netdev@vger.kernel.org>; Sat, 30 May 2026 04:11:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780139478; cv=none;
        d=google.com; s=arc-20240605;
        b=Ijf6FJBs6UWs2L5JgF+ebyETO0dtBXR7zjyHtNUUYejN1olDHLVziODqOf41BwtmAe
         WThqSPkQtb0Ad+nz63rUwz5iT8JrMTGOImHDzax42JjealBqN3c3vCulG4G/zDdSlJXK
         IG1VDl/9lOtgoTNHRPORbyUteHTDG+ohEmjKrg6jyzBjdTy81rkzEWGhrOuwaub3j6+a
         5WuFFrswlWpcYIS6Fu3EDn+yUViFJmFDf3R/SxMRkHcogqwMgU0xOSj8p8Jz26Fxrcjs
         jcEZDwWVm8DrkjLmpHUTXws7fps0l1/U4LwYJSgqPj8ECdfGVyE68XF0zL+zXSLxbTX4
         TIRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5W2aE3S05lfZxC+0l9e2zIWzh1sbqU2nXGr4m5mTLJ4=;
        fh=jpZfqOE2rMBZrwY6ZQ01paESzYs3MtEEuWuPjEZfst8=;
        b=Ibw9/c4gcsHfWcSDpz21K01SNMiEGfHBW6Yvmq1yYXsXeKO3sDURix4MMeMC/MLjAY
         jhH15auxD/HVP6WLB3KkxwfEFuFzs357pqn6iEl+UMxpXqDykdLd/dhFGiQiqiJ/Pxcr
         X9iZEHQHf5ovrmeug2VUUw4NhJ33mg8C6IyVZThsJMAIODFnRDh1NB5+w/zd3tbt/xDa
         P/zqOe84CWWm0fWyImItso4Q5CRRd4OLAkCA+3FvkS5CyEFfSm/SuZ0Be+FLUpHlzDAn
         Ia6bz+L1xXkb+F5weKse5XBRGQ0kw96DNnRDVcyOqwCkFkS9uBRKrLeqBY2pfDLWBcMN
         qz8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780139478; x=1780744278; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5W2aE3S05lfZxC+0l9e2zIWzh1sbqU2nXGr4m5mTLJ4=;
        b=WAm/6E3ASO/fd6AwQ56s3JkhoxzEL08UYRFshYk0BLh7xJ5tvNG4jM0QJwstg2YqPq
         0c+uUJEXIo3dQufxMqZR0eaQq9m9J1PalZLOkArEEmSzty1mN163qGc3SCe+rZQiWgvB
         VJYd76u7xevzCyh+HgyBOIUr0pFnE9HPsdrcCAkLmPnBAQaUxhOL0xwlr7tZX+/zW5lg
         AAdSRjIv7clGAToTi7A719S19pHeoRDKA3Mn/p0+vRYGhaSTA4WP0ixiquiqqjYv1Kyk
         jOgk1VitD/94C15D8zZzjsjPQNw6kYbj4ezUfOB4kLJ1fr1I5DKzX/1mJAGosMxsDd7K
         Rjfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780139478; x=1780744278;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5W2aE3S05lfZxC+0l9e2zIWzh1sbqU2nXGr4m5mTLJ4=;
        b=GOZp2EOrTXnXtTfwvTY315SVgeABoAgr5104g5Ft/iaf6iN1xU/bF3hwazyH4x4f0s
         siScOTzx3qXSLhsvYQEGxTdaZ71GPE6odFrI+gfJgp1dvi88sGIKSVAk2ZqutOcAGoD0
         Gi4tVmFAckD/2lfE1dSEfeV9WhHpO1S3OdFgllIIm7ew3uFxYv2yf2FYoOSB/c4Q8c25
         +XezfPjaqzdhPRG7JmYqDiHgK6rNj3Qj648ak9/jftk66TyJIBUsuQN3yZBodCv9VJVf
         dr6TY8T2VhOx63CkK/05+Hkvr/mag5bb05vipmvEscftgoHD6mMlig87fUSn0Y34NKwu
         CxMA==
X-Gm-Message-State: AOJu0YytQx3gcFnZ4nVTs3HPJcAvPok2tKtQWU71J4Q40SwDRyTN8IiL
	dRsmoJK9Uq+pDF1z4dpfmPmI6xEir0HvF2QbbWx+PAfjYjMurqK6vNOzJxhGOXlywwD9iwErBQs
	pstnSq3UurKJb6KJ/O7X23XuZO1A7sWo=
X-Gm-Gg: Acq92OHZVAqyqL0mpWVYH1sJZON2HP6Z9okN4yn7TDL4PSp78H0l5vg2DwTIpzzbxuo
	6tzTGrduWmK+Pj3RlBaPieeV2O7TSzHtl4JOlkN6EJ49yBhnJy6uWfaGq20qRY/XYgUd7q01afz
	8EUWup8kMuLIRby2lMIWj35S8Vc4y6R01IU0YyrJme0KJQHEkd1fZ5A2CrIddm+LU/XQV8flHEW
	lsvrz8oBNVWnekEqLq8Vfuthxwdsn8kubkfLZVO0O37H64kSlMcRSpIe5l2DYQvoWT7qI9U5LnG
	PuD2TsmwaplgOqxivtdn+6STaao+e4z1RL9r7W9X3Zur5Qtv4w==
X-Received: by 2002:a17:906:5a49:b0:bdb:7c37:183f with SMTP id
 a640c23a62f3a-beab492ab06mr113143566b.4.1780139478124; Sat, 30 May 2026
 04:11:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530-realtek_forward-v10-0-d14b51e6a69d@gmail.com> <20260530-realtek_forward-v10-2-d14b51e6a69d@gmail.com>
In-Reply-To: <20260530-realtek_forward-v10-2-d14b51e6a69d@gmail.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sat, 30 May 2026 08:11:05 -0300
X-Gm-Features: AVHnY4KpyFRsq7FogQXo5tfnpolqeUCHfsCg6V8b8Mg-TglryqlWovAPVtLwb4Q
Message-ID: <CAJq09z43qpAT5zDSBDTGFTdDPMNKnHC9wHmWfFDWY_H1pKeC7A@mail.gmail.com>
Subject: Re: [net-next PATCH v10 2/9] net: dsa: realtek: rtl8365mb: reject
 unsupported topologies
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293341-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C229060C63C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

>
> Explicitly enforce the presence of a CPU port (-EINVAL) and reject DSA
> cascade links (-EOPNOTSUPP) during setup to prevent silent failures.
>
> These topologies were already non-functional. Without a CPU port, the
> driver does not activate CPU tagging. Additionally, the switch hardware
> was not designed to be cascaded, and DSA links never worked because
> CPU tagging is not enabled for them.
>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

This patch was extracted from the next patch in the series. I wasn't
entirely sure if I should carry over the Reviewed-by: tags to this new
patch. So, even though the final code is identical to how it was
before, I intentionally dropped them just to be safe.

Regards,

Luiz

