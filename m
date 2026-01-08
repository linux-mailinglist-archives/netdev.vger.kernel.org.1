Return-Path: <netdev+bounces-248149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 85117D046AE
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 17:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1F48430E3CA0
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 16:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3462B261595;
	Thu,  8 Jan 2026 16:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b09EQmjR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083192356A4
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 16:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767888836; cv=none; b=L4rFNxUaNjQYZrSI0ol3ayETqVr66el9r8ow+v2iiSiVuaT4rzlaWdDktCJjInoCVjul4IhzBEA1EX9HOQAg4/PrDsQ1TOWYrXBH6XQEAD8ITPR1xNM2wGe1UNkIkr9LqX7tsWRWr8r6bgptv3R/kvyKFP765nQCjO7JNJJVM/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767888836; c=relaxed/simple;
	bh=pfAEOHBnyjiXFEQwRPHC5G8VZWAFvQre8RRODkn9+q0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=X2MzcY78GZrFR59JQVWUogDA47XMVZcv7/Vxr6CinSeEWEjhsHLtL9lhMNXvPzTeXGyfUFYiJSH9y9+QD7muSz9rOQjD6YvQrona+6FQr0dxAV8tVciuqm/lrRf+4hS0esUcY+lylHGA5r4szXlWKf6JaMb7gn5wbnTWBafZzow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b09EQmjR; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4327778df7fso2027376f8f.3
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 08:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767888832; x=1768493632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/VGGRnLC/Lr7Ss9oUphA/cRoNvZ0xmHMzdG2j/UIxqQ=;
        b=b09EQmjRySkBX8iwToggWHpOtlzb+1ak1LL5/CWd1GeXQ/wJatDQDyJdNt8HAfCOjD
         aPpnxKySud1Biu26mOx+zaabgbi3y4Q6oyoYj/CSPC9j8gu4Yl9m75Fbh76hiUfvhTb8
         DXKVozIvspc1pJEh8JuvP2MP9CgBnwGa6/oE+ZAbfJxb+CZNJcrbVkU5k2/pXEK/AyMm
         jQt4qYuFZVOOBLpSHyRLN5WfiPhosiY1qcdjV8vxt+uOVdjPz9P1jonUWe4bk7ET50uD
         aG8+hGXuoY4OoWR44zIHNHZPQoCde6LfK2y4FWNTwUp3mS135QV9P5KTwnyJcq6lkBdn
         KgRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767888832; x=1768493632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/VGGRnLC/Lr7Ss9oUphA/cRoNvZ0xmHMzdG2j/UIxqQ=;
        b=CX2Mm3mFS/RVr6m6zGiSirPjN1MKoHRbyJ02c9pFfeHm8dikyRt9mKejwk2pdoDTKI
         wamc+bW1dzdynN28LCS9ysbQwfxY7PokKVVOVONVur4lGbLT5nsplTJd7LEDDJJ8ZZn2
         hqKEmJHIqOtaowvFsqPFgiYZWMb4pqwj09DabLS0SLe9iwcS+qY8/UkB4RLszuyFvThO
         0eO+IINuUcC6FPcoa4RTa3NjlDCSo2gMBNFkv7fz3xZiqIyqJYGTwmUJfNQQiEi9YXb7
         flWmBR0U1qjgId1My3wtGCADHu5Ab9+/MolKiEZXepw3LMhohTHLVxj/0rsY1oWYCzls
         1a+w==
X-Forwarded-Encrypted: i=1; AJvYcCXDmAuzGuG13mU5VlCgNWbslJzZklYF6IqQcBK3adAgkmNauJP0+CChGxLcc1mCet7zaEz6EjE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxoe31JLjtHbA7Ow/DvRXBCaxTPWclstQhdgUtdCW0UCjR6wPjb
	B/EEmfM70QO9BWwmHSOIN6rT/O+I38kvWE426TCfeyw3hj3mT0JA3K5w9LOXxw==
X-Gm-Gg: AY/fxX7nXx75/UX6vuuj7zNdkUL555OQFYttS7C/XFanSTT9wpo9gj9912LBojVqrAy
	OLcqqF2FG3cltbFyyIQFLxJV9UcOLyuirJ74TA67qBjgdUW6E1coaR2x79kpwla6n4//RNbiwAX
	7684JxM+mX0ehfMrdncI3ydt2nfBHP45x+EN+lY5Ri0GER8mWqaqEBgzmNmP3JYflApjDC2Gx1t
	BCL27j+xhL5Vpj+tPynkbB+Me8f8FQ55SkLIf7D9o5JnoyT9nd9WP18qcnD2Zxa8Jp53xbRgPSY
	bsSXdaNRPFvIlVcpWrdTZqEjV9TSuDHdBRwM4whUtcYHnGFpefPjU5l54kmSwjeroZwy2NO8Lt7
	YwahS8kZH+u++l/NTstUmmPQk+RVMN9pwO4mB+z/j0HoUFk6xqVzdpaSW/F1qQsApZ76sXiVEux
	B56Ll/k4I4mDk6yzusp6GIRAQ9kj6V
X-Google-Smtp-Source: AGHT+IH0O2YwmBD8Gu7R9D3URmNXYoiVElbVWRS+klDJYvcMlMiQcrcofvkDstlbzoLJHl9Q6TIy1A==
X-Received: by 2002:a05:6000:40e1:b0:431:488:b9bc with SMTP id ffacd0b85a97d-432c3629b8emr7985479f8f.10.1767888831873;
        Thu, 08 Jan 2026 08:13:51 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:8115:84ef:f979:bd53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5edd51sm17140039f8f.29.2026.01.08.08.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 08:13:49 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Gal Pressman <gal@nvidia.com>,
	Jan Stancek <jstancek@redhat.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Nimrod Oren <noren@nvidia.com>,
	netdev@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	=?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Ruben Wauters <rubenru09@aol.com>,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next v2 00/13] tools: ynl: clean up pylint issues
Date: Thu,  8 Jan 2026 16:13:26 +0000
Message-ID: <20260108161339.29166-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pylint tools/net/ynl/pyynl reports >850 issues, with a rating of
8.59/10. It's hard to spot new issues or genuine code smells in all that
noise.

Fix the easily fixable issues and suppress the noisy warnings.

  pylint tools/net/ynl/pyynl
  ************* Module pyynl.ethtool
  tools/net/ynl/pyynl/ethtool.py:159:5: W0511: TODO: --show-tunnels        tunnel-info-get (fixme)
  tools/net/ynl/pyynl/ethtool.py:160:5: W0511: TODO: --show-module         module-get (fixme)
  tools/net/ynl/pyynl/ethtool.py:161:5: W0511: TODO: --get-plca-cfg        plca-get (fixme)
  tools/net/ynl/pyynl/ethtool.py:162:5: W0511: TODO: --get-plca-status     plca-get-status (fixme)
  tools/net/ynl/pyynl/ethtool.py:163:5: W0511: TODO: --show-mm             mm-get (fixme)
  tools/net/ynl/pyynl/ethtool.py:164:5: W0511: TODO: --show-fec            fec-get (fixme)
  tools/net/ynl/pyynl/ethtool.py:165:5: W0511: TODO: --dump-module-eerpom  module-eeprom-get (fixme)
  tools/net/ynl/pyynl/ethtool.py:166:5: W0511: TODO:                       pse-get (fixme)
  tools/net/ynl/pyynl/ethtool.py:167:5: W0511: TODO:                       rss-get (fixme)
  tools/net/ynl/pyynl/ethtool.py:179:9: W0511: TODO: parse the bitmask (fixme)
  tools/net/ynl/pyynl/ethtool.py:196:9: W0511: TODO: parse the bitmask (fixme)
  tools/net/ynl/pyynl/ethtool.py:321:9: W0511: TODO: pass id? (fixme)
  tools/net/ynl/pyynl/ethtool.py:330:17: W0511: TODO: support passing the bitmask (fixme)
  tools/net/ynl/pyynl/ethtool.py:459:5: W0511: TODO: wol-get (fixme)

  ------------------------------------------------------------------
  Your code has been rated at 9.97/10 (previous run: 8.59/10, +1.38)

v1 -> v2
 - Fix f-string compatibility with python 3.9, thanks Jakub
 - Fix AI review comments

https://netdev-ai.bots.linux.dev/ai-review.html?id=40420bc1-8119-4977-8062-e2047d90ae91

Donald Hunter (13):
  tools: ynl: pylint suppressions and docstrings
  tools: ynl: fix pylint redefinition, encoding errors
  tools: ynl: fix pylint exception warnings
  tools: ynl: fix pylint dict, indentation, long lines, uninitialised
  tools: ynl: fix pylint misc warnings
  tools: ynl: fix pylint global variable related warnings
  tools: ynl: fix logic errors reported by pylint
  tools: ynl: ethtool: fix pylint issues
  tools: ynl: fix pylint issues in ynl_gen_rst
  tools: ynl-gen-c: suppress unhelpful pylint messages
  tools: ynl-gen-c: fix pylint warnings for returns, unused, redefined
  tools: ynl-gen-c: fix pylint None, type, dict, generators, init
  tools: ynl-gen-c: Fix remaining pylint warnings

 tools/net/ynl/pyynl/cli.py               |  67 +++++---
 tools/net/ynl/pyynl/ethtool.py           |  47 +++--
 tools/net/ynl/pyynl/lib/__init__.py      |  10 +-
 tools/net/ynl/pyynl/lib/doc_generator.py |   3 +-
 tools/net/ynl/pyynl/lib/nlspec.py        |  77 +++++----
 tools/net/ynl/pyynl/lib/ynl.py           | 208 +++++++++++++----------
 tools/net/ynl/pyynl/ynl_gen_c.py         | 178 ++++++++++---------
 tools/net/ynl/pyynl/ynl_gen_rst.py       |   2 +
 8 files changed, 343 insertions(+), 249 deletions(-)

-- 
2.52.0


