Return-Path: <netdev+bounces-152230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C2D9F326B
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 15:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90D101888461
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 14:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A46206F22;
	Mon, 16 Dec 2024 14:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvblsmJD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8D82063FD;
	Mon, 16 Dec 2024 14:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734358235; cv=none; b=N7ubzoZPpSjjEFhi5Dras3vasiUz0O6vzoxtsnTwwuUy0Kb6cNmxlTLwl6bu8qHqIU8HJqkCnn3y4QMTDdH138fWm4UcI7hb+ixfBZeji8gQYZYOfHXayvW/t/x5ELNZx16DLE7cq9AQuRyXljJFwNHEAPG5y+H3VQCFhc0AzSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734358235; c=relaxed/simple;
	bh=2dRA2YKlhk8TY6KgbUVx7gfSgbjOn3YQYpz2eaJ2JBM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=tIqd6q/MLtqQb13LNdSjfI993xuILjan/o86jawjTj01sed7gGcY5Y27sjGFdPH7k1iGJxBu+atUwwVU9Wa1OXGt/M++4WAZ0CnZPSL+BJO/N8YVZURB1BlcRaubHqTBcB2QMt6uik4/hLOiTtwA6pbps2ZBFzMaDAtVPhb5Khc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SvblsmJD; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-434b3e32e9dso45683585e9.2;
        Mon, 16 Dec 2024 06:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734358232; x=1734963032; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OTQVjh1Nlsh1RKpNwoUGZv11vsjJNEm85PixP9Mlabg=;
        b=SvblsmJDDzISiM07bMCfVKs1SxgjEF1Ovh4DlKo7KIZca1EBad54gVPq/C0PUD4Mr5
         onfArU/tDhUfmdYYAxFWjVuh7SktyiF5I8j9TjcxyjPwQdnSMcARxC85OVaGLCAB85Fb
         x7dY61mJFSHzImAvvWrVJ57zeY7ZMTdckYFBeH2yaYBxibDvXqDcVqnEMvu9Dehji+yH
         7DSPfufnYHiLqgCiWwmgoYrYO3Urf8fB1m3yghqRAt+1yvglvWCDLU7J06M6LBhOtp8P
         FipnSakPJ/Lk3hDyAZzlV8t+3yJIhvtjQzFtlyPciIDABCIVald1nyu5KLF86nv2+het
         mAsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734358232; x=1734963032;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OTQVjh1Nlsh1RKpNwoUGZv11vsjJNEm85PixP9Mlabg=;
        b=PbTjt9eB/gnFPobA5nJnG+7fAoZsU2AYdL59A4seLnsZC/JoKlKd5fRjmv5WUa+69x
         y4gJHxrcpGatxA5HfYaqX/xZyeJ9TYXCEqK097nqVM3R4xpXsb3cXLm2NC/5WGbbwbcj
         iiDrIeQJ5eIQGxAvG88oUWnSXU+7HF+6CQn0jYvClV7TW+xL7wKOxcpIkV1h6rbnWMZY
         XRJyYtj748NNZISomXDDLW5U89G8MQaKW/9Rr3BEgQOPaj5sEIRIto+Hrhz5INQLNCBd
         0BhFZfWlPkaf8YOzEZ0CsZacsyOrvxzzm58e1pFVWoz67BrmQHiSQT77482vw7Drb0no
         f7pA==
X-Forwarded-Encrypted: i=1; AJvYcCW00BwN9ZbAIUwzWr9XphDzSAYiUODVE72qPg+gWoqzGLp1eBM7To0f8eK783Xa3axRpMiwWYAa@vger.kernel.org, AJvYcCXA7oFyP7Q4hdCpvbV3PRxcgEON3qFnOXiFWMOxWijGQhpi0wfa1NJSjlq1OeNx0pjL+EMxUhM+5xscvL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRp1SVCqHdS2Y1VYgLu598Us0K16/ydNfbY04jKUUOOHXH68Hg
	7Wse4OsG0mZ6bYSLMA4PVaiqOee9+jbJgPVXK8syp4oIGCyYaF+/MVJkqg==
X-Gm-Gg: ASbGncsR770cNQ5Nirvb2QOkFg3u2J2UYa6UhpcMhBx8gdyWdeJ0bXdraJQftTSl8/J
	H2s/YUY+oA9/o1LVjKRa2fNBscupQ+dRvDpKWMSX77Nfj6EoAUqX1hgzixH5Hav/gnSx7u7X5No
	Xx1b22fwnxvDKxPMJh/KDvRU1KcKzQyhq8egrktLo9T4ttwm/UrPJ2cPugytCWPM39joHuKAYkO
	FBkD2+I8iFBTYNrD3GZutjJ9ivBTpfc+Ju7+MUXjvFOv+qOPuq/J+bGIUzn4ZH42jr9tw==
X-Google-Smtp-Source: AGHT+IFwqdiLGTAhXj0mgR3osoxPiY11HUGfpLY91aE/RDSrMHVJoNQSMaFnRr+XjpKJ3VBFQof7XQ==
X-Received: by 2002:a05:600c:cc9:b0:434:f9c4:a850 with SMTP id 5b1f17b1804b1-4362aa27edbmr135392815e9.10.1734358231879;
        Mon, 16 Dec 2024 06:10:31 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:3011:496e:7793:8f4c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4362559f984sm142291245e9.25.2024.12.16.06.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 06:10:31 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jan Stancek <jstancek@redhat.com>
Cc: stfomichev@gmail.com,  kuba@kernel.org,  jdamato@fastly.com,
  pabeni@redhat.com,  davem@davemloft.net,  edumazet@google.com,
  horms@kernel.org,  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] tools: ynl: add main install target
In-Reply-To: <6e41a47b9ea5ede099d9ae7768fbceb553c6614d.1734345017.git.jstancek@redhat.com>
	(Jan Stancek's message of "Mon, 16 Dec 2024 11:41:44 +0100")
Date: Mon, 16 Dec 2024 14:09:17 +0000
Message-ID: <m21py790tu.fsf@gmail.com>
References: <cover.1734345017.git.jstancek@redhat.com>
	<6e41a47b9ea5ede099d9ae7768fbceb553c6614d.1734345017.git.jstancek@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jan Stancek <jstancek@redhat.com> writes:

> This will install C library, specs, rsts and pyynl. The initial
> structure is:
>
> 	$ mkdir /tmp/myroot
> 	$ make DESTDIR=/tmp/myroot install
>
> 	/usr
> 	/usr/lib64
> 	/usr/lib64/libynl.a
> 	/usr/lib/python3.XX/site-packages/pyynl/*
> 	/usr/lib/python3.XX/site-packages/pyynl-0.0.1.dist-info/*
> 	/usr/bin
> 	/usr/bin/ynl
> 	/usr/bin/ynl-ethtool
> 	/usr/bin/ynl-gen-c
> 	/usr/bin/ynl-gen-rst
>         /usr/include/ynl/*.h
> 	/usr/share
> 	/usr/share/doc
> 	/usr/share/doc/ynl
> 	/usr/share/doc/ynl/*.rst
> 	/usr/share/ynl
> 	/usr/share/ynl/genetlink-c.yaml
> 	/usr/share/ynl/genetlink-legacy.yaml
> 	/usr/share/ynl/genetlink.yaml
> 	/usr/share/ynl/netlink-raw.yaml
> 	/usr/share/ynl/specs
> 	/usr/share/ynl/specs/devlink.yaml
> 	/usr/share/ynl/specs/dpll.yaml
> 	/usr/share/ynl/specs/ethtool.yaml
> 	/usr/share/ynl/specs/fou.yaml
> 	/usr/share/ynl/specs/handshake.yaml
> 	/usr/share/ynl/specs/mptcp_pm.yaml
> 	/usr/share/ynl/specs/netdev.yaml
> 	/usr/share/ynl/specs/net_shaper.yaml
> 	/usr/share/ynl/specs/nfsd.yaml
> 	/usr/share/ynl/specs/nftables.yaml
> 	/usr/share/ynl/specs/nlctrl.yaml
> 	/usr/share/ynl/specs/ovs_datapath.yaml
> 	/usr/share/ynl/specs/ovs_flow.yaml
> 	/usr/share/ynl/specs/ovs_vport.yaml
> 	/usr/share/ynl/specs/rt_addr.yaml
> 	/usr/share/ynl/specs/rt_link.yaml
> 	/usr/share/ynl/specs/rt_neigh.yaml
> 	/usr/share/ynl/specs/rt_route.yaml
> 	/usr/share/ynl/specs/rt_rule.yaml
> 	/usr/share/ynl/specs/tcp_metrics.yaml
> 	/usr/share/ynl/specs/tc.yaml
> 	/usr/share/ynl/specs/team.yaml
>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

