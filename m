Return-Path: <netdev+bounces-256661-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPMpMrccg2l/hwMAu9opvQ
	(envelope-from <netdev+bounces-256661-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 11:17:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F73E45F3
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 11:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A947D301E946
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 10:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB7A3AEF54;
	Wed,  4 Feb 2026 10:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/IqWxko"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642EF3A7840
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 10:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770200156; cv=pass; b=boS/byIgoCQeMk6LrKviHk9cZ9GAh5Xo6W0gujoaZyamtgHz9ZnLyt2la+0NhKcXjZqwHLQpB+nhuBYdB6qguaXkrU6xbMj3G5ZO04r9f8x89RwytKajFgIdcejpHx3th4w92PJoeXQovEWaIg2eX+nNaSdtQ66MXnywutHgTRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770200156; c=relaxed/simple;
	bh=U2SZUJ4vwKEV8AGXg/Pcz7quXw/+sB9ZkQglPIRsmo8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=GyWG9d0Cj3OQarMlsJJjjg1ypl1S4s6E1u4/WcXliaj2gI80L3WaK0SBHp766cTB1E7BEhg/Q3mAJyPWbtfK/3SNe5EbTSDoyPkldmyuQeXkm/2ViuP18neC/qkbTJiQqm4OxL2SW9624fs0oKLxyKSOloEXQQdeYQEvRg4McSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/IqWxko; arc=pass smtp.client-ip=209.85.219.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-894770e34afso88347046d6.0
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 02:15:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770200155; cv=none;
        d=google.com; s=arc-20240605;
        b=YrkP2CR9XUB7LQoQvlWF2LUfUvC1x6q2COOgCsrN+Y1G0Ywx9wS1uK1P+ET6e5GTEj
         crhBTygdyEcRMYCsngtD79eg3FWozeEqr3ya0aE6spoe4hMCUum6pYUfIdfSxSCAFiQK
         UkbWcOyVntuxixO1Nd+j/dFxiy+8ttZY9hfoqAv21z2c/JJS4BPJBkcZ2fBrLJtJZme+
         OX73tGW9zgrCnQN3UiUmuzfi5Gfx6rwUhg3chBXWHG1FGMyltG9vkT/nIGQgUHIif9Ai
         DbNR9O9ecMIapwFju94WIesezB0mwQlg+uCkh2sr79Hgfnm4caBnnjXQZwbcXKqUXXWt
         PFgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=U2SZUJ4vwKEV8AGXg/Pcz7quXw/+sB9ZkQglPIRsmo8=;
        fh=ftt7bQdbPP2JhlLkrRLcZuiJ6zaoCnvsaFXhPkCP1Y0=;
        b=cYWilqEf8uyQBRgD649lYQn9enDaMa3F6op+OiGjkNm7v7npv/8ZNXya5zRtoiRnhC
         nG3YlBBFMU0YEPN6TPuEk6i6Z9/s6eQBXlbuhTlSFnkUr/+WEE+m2rIiljoiOGmQW+3o
         eZWGWm2ZB4mrnwyVKFvhOQseB/8LkvzexOnBs/Kdy2daKNpk+fHlcc1sU58w7/cap4d6
         8o4UvLXb++AJuwdLYEJnFIYIy38/7KU418595qdQpximAXgKG9rnTJhxsNczCC4n8Rzi
         NU0oeFCWpyM2G6Zx5TDUkSU/VtfraZEdZpOPxYACYzLrXpI1EkpgQNQ/NiJJ97lvi6Gd
         Fszg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770200155; x=1770804955; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U2SZUJ4vwKEV8AGXg/Pcz7quXw/+sB9ZkQglPIRsmo8=;
        b=c/IqWxkoTmZTqchniIeBJw01/j4HCZ29S4PHSoPNYvNI67jYmEOZNlCjtZvpqKzwGk
         6g0RzCK3C+U+/iWCkXnOaDfplG21lUOV0gtJPVWg7gAF2m98Jg4wkndKs3buscbrJu7X
         zIUwTzLlIf95ET3NSXGULTLeE8thcCQoLxb4VXNEI/ghuHPAFAIL68hv8DEwJXAXNdDn
         iXsxcG2FjdYgr779waTclKcZ508uQSVzzpMNzBzTwIaK7Pw+kTNw4/roDksU+TO9tqo4
         d5wxlnLl3oby+DSy54ixfr/RxCmADaU0kMWSoJIb7G88e0UsmDIzIFgT9rgCll9aBGjL
         Kmlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770200155; x=1770804955;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U2SZUJ4vwKEV8AGXg/Pcz7quXw/+sB9ZkQglPIRsmo8=;
        b=mnBycVrGFElynziqf2Q7LJM5eL5U6Jtw4CU+sopWAq7IpBASiawzSv9zN1EeZYlGHi
         w6xg1xkTwZ7+gMTG9iz+lRvf9tCRO0QKUbA6ajfhWPAdXc9GUYpUuxiCLBHwD31LlfqA
         JFgSUFKieZFbW0mTBDlSw9TE1k9cs446M7GohzrMk8JuUI0CRtb4Sb+CYZKEUIUHdrV7
         D5rZf5wgvTsoAWWzUynSaiOunMaJuRvQaTJOHEq3fgc3nCzfrMgBs3f397eSqzmv4LW3
         dZ4TWTYx1ymX1UBjdzeBehRUHDgB6Zi9EaQTxItlh2G3/IHCPuQSsdQlVCifZO15IGdD
         8lAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkiiuvs2T4Qu35NoR9xTnbGKqrbCaW/fO+vtUbWp4z2SQ5MF5VboIi82WdqnHqU3b8NPs50RE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSbh9rXDftsivbJdkScEh2WweESoUWN4woiTuucVvqSPLxSW2B
	VAAyuObQ7DWhvyI68hsExjVeoVVhSZwbNTuUAQ9epbQVFs3CVzZzIkJKypN/j2QM81BqkwlWcTP
	JgGAEtQ4C9uuXX3yxkp/LPfqyTjfwNjw=
X-Gm-Gg: AZuq6aLT0W+8Y5I2kpz30WJCYB/gLalaZIgrE9gRh7D22ZeodR5ThGyVXPVUEPthY1t
	Tik89fsc6BcqnAaS0bEdF6P8C3y5F64nc5UTrA1/xSfNErrCAxQ/yekLcsZ5w07OrcMVaOLeE5y
	ZeSyIX7rcRgmPXYNz9/28rL4FflwAKUcv0sWz/51zPuJDjutgGfovO6V/QWgOlks5QG/wdKUVGj
	SmyaxZB3l2vnHUqS/0yd+KyJFF/y0Js31dcpa64/dI8Okeoe10OqUrBvq9xVLVgMe+d+PMVIPsa
	hTL9uBPORHzqbqh98b3dmJ+cNt15fBsyvmy9nwkR8HaZFwdpyndrOmNU
X-Received: by 2002:a05:6214:410d:b0:894:5f6e:fde3 with SMTP id
 6a1803df08f44-89522101930mr33818186d6.19.1770200155305; Wed, 04 Feb 2026
 02:15:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Wed, 4 Feb 2026 02:15:44 -0800
X-Gm-Features: AZwV_Qhu3PjSdqm3E8rcFb457xyh_rZqtpf1XguM6GwwOWxTIMYwBBEqTi_NSxY
Message-ID: <CADkSEUhXO-01yaNUawo58MQ=xOC5bCDHWCFrCwe6TX2D+WVR=w@mail.gmail.com>
Subject: PCI ID conflict between ipw2x00 and i40e
To: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stanislav Yakovlev <stas.yakovlev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256661-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 51F73E45F3
X-Rspamd-Action: no action

I have written a script to find device IDs that are claimed by
multiple drivers in the kernel. It has found that the PCI ID 8086:104f
is supported by both drivers/net/wireless/intel/ipw2x00 and
drivers/net/ethernet/intel/i40e. I assume the i40e one is correct,
since that's what the ID is assigned to in the pci.ids database. Can
anyone at Intel confirm this?

Ethan

