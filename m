Return-Path: <netdev+bounces-98613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 141E88D1DDF
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 16:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CFCD1F21B1D
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 14:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CBA16DEA5;
	Tue, 28 May 2024 14:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4I1FZxQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F24E13A868
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 14:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716905227; cv=none; b=keICPLEdWsEu2OWTqzHupXMnce+E0dndYs0BF7QVIcSNr7h42olHzOyKurrmlLj7rAIq8B5BDj6QPSrlniCPG7Bw3czAcdWPITRP1kfQaKX8k8L3chW7UT1RYKVhuuGj6sI6pdb23jaVtd9hGl3I/rrYKQbdkA9X0cgPnpHeJ98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716905227; c=relaxed/simple;
	bh=fQjYvKKhv8ym8zn4lIRKjYrSeuetK7bI/mcd0UkNOlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nt1e1nwBm3neWu2EJ+ynlsDcfUPbRhRR1NWSFAhD3S5n+GQgZLr8itIcixYjca5Tm3uXR10Hp2jR9ZgEaes8ZpN8ZsKXGce3V3ryrWNhaX56n+iASQLasRkEBcUEBLU/g/V35r8ouda2TvQjlbp6g1L1ckmlNEsokmGQ3fvpf1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4I1FZxQ; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-354de3c5d00so540481f8f.1
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 07:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716905224; x=1717510024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GTRioXgS5s/kcRAxzcN2TMmVwqgYRaOdFBW6Bj8HD3s=;
        b=T4I1FZxQ1mE+8Di65NQHZIJjNasJQDO2BtNtwPBzLte8XU/9ObUiXQLAKfFpPAbKem
         AuuiZ3pYNrC5DKGSpwUuM/wXH56p3nKCwdQ4TTh1TjkDOr1feFMjeRi//SBFlQD7cxss
         dNdquPiocP+cy6GCYomqv9mb8CQjUbUGInE0bg986SciGpy27F8L3Ptnkt8c3BM+ljYz
         BaufxGQPB4+DAJ8q++eTmAyFDYNcgkBLJ1cnQGHO+b7o+mzinCBCFgOidM95L5tyhsJ+
         0/Ke+IyXIwy6XtBE5Xv9Ys37ElG5+oi2rXU5uY9RSwlMqHusyUUQ8ZeXEUXXKlHKStGY
         I5CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716905224; x=1717510024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GTRioXgS5s/kcRAxzcN2TMmVwqgYRaOdFBW6Bj8HD3s=;
        b=poauXV7Bj99bAfZAeOQ4s84QBPWgfKrvzW/2V02TGO+7wTJXdBD08Frv/HMvBFwmPJ
         F/35beDniw46OdNLKg9dws98j9MSVJF059VY7WgibZmKzChDL2hV/kwUitnnS4vMXsAi
         9KnwaHvLpkH809lFot575p+Rs2qUtVmoXA4OK65MiQ0gNAjq6BIsmxNPggE8CI0L7k98
         /fhP/3OmFMWcGtnT02LIdJZyh9umU+FMCM8gr5HckNnR4jkUY2UA88pkUsR0nozptkMa
         PCg8+IcPkUI/0vbfOG1Oq2zgK8QeVDvMDxcVRrgy7j6/m9TYfI0jVePNVdDhGQXxrV6F
         yK0w==
X-Gm-Message-State: AOJu0YxrGLGXsWkwCxMoz3yEH530agVNoGR0A7SsQIii/OSPubn/HAA+
	jZdxwFroT0aCRwfxUkF92twSaRMtp0PdQRTjmjWInNoOr17bGeqiRThiL5h/
X-Google-Smtp-Source: AGHT+IEgSBZM0O1TW9w1jhxogfd34b5XY/uExFm8vEV3nnrHYbDcouhtMEx7sXwjRF1CO0d64dK4fA==
X-Received: by 2002:adf:ea88:0:b0:350:2ba9:ca03 with SMTP id ffacd0b85a97d-354f757cbb5mr14287525f8f.23.1716905224171;
        Tue, 28 May 2024 07:07:04 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:68e9:662a:6a81:de0a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-359efaf5402sm4534599f8f.78.2024.05.28.07.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 07:07:03 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Breno Leitao <leitao@debian.org>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1 0/4] doc: netlink: Fixes for ynl doc generator
Date: Tue, 28 May 2024 15:06:48 +0100
Message-ID: <20240528140652.9445-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several fixes to ynl-gen-rst to resolve issues that can be seen
in:

https://docs.kernel.org/6.10-rc1/networking/netlink_spec/dpll.html#device-id-get
https://docs.kernel.org/6.10-rc1/networking/netlink_spec/dpll.html#lock-status

In patch 2, by not using 'sanitize' for op docs, any formatting in the
.yaml gets passed straight through to the generated .rst which means
that basic rst (also markdown compatible) list formatting can be used in
the .yaml

Donald Hunter (4):
  doc: netlink: Fix generated .rst for multi-line docs
  doc: netlink: Don't 'sanitize' op docstrings in generated .rst
  doc: netlink: Fix formatting of op flags in generated .rst
  doc: netlink: Fix op pre and post fields in generated .rst

 Documentation/netlink/specs/dpll.yaml |  1 +
 tools/net/ynl/ynl-gen-rst.py          | 13 +++++++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

-- 
2.44.0


