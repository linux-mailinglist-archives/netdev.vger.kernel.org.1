Return-Path: <netdev+bounces-180428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48947A814A7
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 20:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7E5B88719C
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 18:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099CF2309AF;
	Tue,  8 Apr 2025 18:32:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2624A134B0;
	Tue,  8 Apr 2025 18:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744137138; cv=none; b=Ys1PBAe+iDnn1G86de8Lc2A1cV1DsmlKs13bl8/duDPSfED1xGqQpuO/FOMnVEBrhierL11SIyGk1zMWVH+moKst+B9ifqgXxCeCxBJqwObS67B/kr22r3zW/9exhhU79l011RgCTldKR4n+Vm5L03PmRSH4gqvYUcGUkcSekX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744137138; c=relaxed/simple;
	bh=i1BDeE4GSimM+P6Lq3/a9QqpA134jHYI245rl9LGjGs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=l86Chqwf20cfFBEpAsO6LsiJ/7Ff8mTobKFx1g/mHsM4yQZmGGU+O1CQCxILANxrmDPmndjOhChN682VCp/52uzVp6O0MzvD7RKKzE+1Q9RFwft93hDDHNzFcWBzkfbi+tC26Kn1q96vXBWCxCsKer3WDJ1eU+jDtgih5imZBEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so944477966b.3;
        Tue, 08 Apr 2025 11:32:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744137135; x=1744741935;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RUE11QrC21kkAkrsHUVd8QJcWCfol5J1eLabiLpd2K4=;
        b=tDIECmx96ksHcCq0B0/dImZaP3ScJgGcZssXEsNIBHJ3+T3KH8/VNQH271U+Sw7D6D
         wPRzwl/0zPK6Z1BFETBpMym78m9iVEyjKwohG6gnTUyMr1I/pqcFjbFjR45UlIUcrvnM
         4VPb5AZBKKWb44LI1GpbUIIrJYk5znYZEVP+E9+MAA8meowePu+pJYnGFJsqKSKlCJns
         9Z448MO1jIIpwcQXnwwmGFjE1v9JG0hOvhsPItkbYNYJ/Ahexe3mJ+gJXHbucL1WpwuT
         f1dYC+VSQmkjwpFCtQ2+hSxRNSgsjjMCmaqnyJ4dMeILcR8gsOrSw+u35GaN+yLd7VLi
         EIdQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3jizlwcvnkhXduFf3tqVvGWUOCdn8JDhUawiVg/ecU2+YAE32rMoorV/WX+eLWw3MKY8oup2vBTTsdgs=@vger.kernel.org, AJvYcCVfkzkQI1kKsxqyrC/nxcHI9j77beWBxIPUmkZ33LrNyxSB5UUp34ZDH+T4KJoqbqAapug+IHtNqLMzR5F4HcA2Foqo@vger.kernel.org, AJvYcCWlvC5JvdsXT8VtUiGFZxNlpjdU9nBICl1LNKNDj+GaX/3pzz01b+y+kL+5aXqZ2jXPbMQbzO5J@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/l8CZZauL8ZLNP8a0y75d4w07ANoldTfv0Zugw/+WH4Qjtmtt
	V3u6JGIPU/ZRYUkJ583+P+qtByo/karNZEcwrpiNpFT4u3V1UEp56XYblg==
X-Gm-Gg: ASbGncv508tAhAwzBoFeDa6q+NBqo7Q9Vlurf9+sYetpunf2zh2AukzOBp/QJjflinJ
	vDm7YC/6qsJ5polQ9EKcWE0eyhWSSXNovU17vkXbDSAYggmGJieyWFghuIFZmwJePxZ3DLksXI8
	5Jp1nisMvoyUmyugTvn/GcdeGMFa6BuI6ZI6uPaQd0bLUuoMNPyFiRwGFaoWyDeUF+yeua8Y92s
	ngIDfyMxrkSsQ8NlKBj2KOm6P2mVTtbO6ExvndO+L6E2ZxiQVkowGhKThR2sOCGzaN8uHrpHU3b
	8LvAoO5MRyWdylD2uPpYCi8bS45wjH+PQXU=
X-Google-Smtp-Source: AGHT+IEc3HB5fc5q8HAApvQ9C22fQFLe5843xllZGCqRDVOrC7ML8ay2u3pblmUcU8MAtmbOUvOeTQ==
X-Received: by 2002:a17:907:9712:b0:aca:9615:3c90 with SMTP id a640c23a62f3a-aca9b74629emr19952966b.52.1744137134815;
        Tue, 08 Apr 2025 11:32:14 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7c013fd7fsm966909266b.107.2025.04.08.11.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 11:32:14 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v3 0/2] trace: add tracepoint for
 tcp_sendmsg_locked()
Date: Tue, 08 Apr 2025 11:32:00 -0700
Message-Id: <20250408-tcpsendmsg-v3-0-208b87064c28@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKBr9WcC/23NSwrDIBSF4a3IHcfiK81j1H2UDoxeEwc1QUVSQ
 vZecFICHR++/xyQMHpMMJIDIhaf/BpgJLIhYBYdZqTewkhAMNEyIRTNZksY7DvNVDmmhbx3Lbc
 dNAS2iM7vNfaEgJkG3DO8GgKLT3mNn/pSeN3/BQunnE7aMCVNOxjTPyxOXofbGufaKeJnFesuV
 lBGB8dQ90qiG4aLPc/zC0QIpRLrAAAA
X-Change-ID: 20250224-tcpsendmsg-4f0a236751d7
To: David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1609; i=leitao@debian.org;
 h=from:subject:message-id; bh=i1BDeE4GSimM+P6Lq3/a9QqpA134jHYI245rl9LGjGs=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBn9Wuts26Mlzm+Zc3jDNP3m91BHnRxDLAFRGBZT
 t6aNoWGNM2JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ/VrrQAKCRA1o5Of/Hh3
 bSGCD/9gv53RBICy4FUhyPDX4H0FuuNyJUTeP2fIXmg//z0ymVw4tJSXIXFuEbyIbuJwnEOEmVr
 1/s8e/uv7jELlNBDvx5d/yICS9zSMHDOF6SxxmOWSGqeZfuvo47vRPzJGRgusQamU8XiFulcqp1
 bTayMCNkd0DRvhE9f3r1BA2Vr9ptlj7D8HnbeClEp1GbsEcfGb0EDzdv5y75OUgbYVnhkRNC2dy
 sn3yGOJ5aLYgi1vL1SAV4bZLcvgie5M1ENKlJ4QXZXTNFzbUE4/d20spA67QJ51KQ02rQBVfI5H
 mBSvkuUNJ+e6ml2yg6peKbWbe9fR3FVRXIIBbKISBH3xmc4tWo6ZHfyoIiWTrXRVQTijKhvW/Iv
 qWjzn8x8n+yuFCd7obNyC2OIOIFD+M4fLotnYH7e5doptQ4WM5Ko/TXaFWG75MR8L2bMOamcGpf
 Go8L2rOahXMA1GsN5V98j5xQffGlJokNimbJQdlqQRuj8mBREQawFoaywF0Z1NjK1UgBsXPHIpN
 FMyzmcfJXfu16sybU+VT0f2sda4/ZNmEN2GlkeX9kfB4N4SXsDxLiGZi2X4p8SC0nSfzfGn1M90
 4VF7I+nzAR20cc5CYrUvUFvKLaoX+F7R8jts8vFHUEeDd0QsNIZgg4zuTk0GVqx7zZSQD/EStFm
 zWeBXg5xC82jqOQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Meta has been using BPF programs to monitor tcp_sendmsg() for years,
indicating significant interest in observing this important
functionality. Adding a proper tracepoint provides a stable API for all
users who need visibility into TCP message transmission.

David Ahern is using a similar functionality with a custom patch[1]. So,
this means we have more than a single use case for this request, and it
might be a good idea to have such feature upstream.

Link: https://lore.kernel.org/all/70168c8f-bf52-4279-b4c4-be64527aa1ac@kernel.org/ [1]

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v3:
- Fixed identation (Kuniyuki Iwashi)
- Removed duplicated entry in the commit message (Kuniyuki Iwashi)
- Added tcp_sendmsg_locked in bpf_raw_tp_null_args[] (Kuniyuki Iwashi)
- Link to v2: https://lore.kernel.org/r/20250407-tcpsendmsg-v2-0-9f0ea843ef99@debian.org

Changes in v2:
- Change to a full tracepoint inside tcp_sendmsg_locked(), heavily
  inspired in David's patch
- Link to v1: https://lore.kernel.org/r/20250224-tcpsendmsg-v1-1-bac043c59cc8@debian.org

---
Breno Leitao (2):
      net: pass const to msg_data_left()
      trace: tcp: Add tracepoint for tcp_sendmsg_locked()

 include/linux/socket.h     |  2 +-
 include/trace/events/tcp.h | 24 ++++++++++++++++++++++++
 kernel/bpf/btf.c           |  1 +
 net/ipv4/tcp.c             |  2 ++
 4 files changed, 28 insertions(+), 1 deletion(-)
---
base-commit: 1a9239bb4253f9076b5b4b2a1a4e8d7defd77a95
change-id: 20250224-tcpsendmsg-4f0a236751d7

Best regards,
-- 
Breno Leitao <leitao@debian.org>


