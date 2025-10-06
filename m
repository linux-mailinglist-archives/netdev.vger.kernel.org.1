Return-Path: <netdev+bounces-227987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A09CBBEA3A
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 18:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D91363C153A
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 16:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6802DC780;
	Mon,  6 Oct 2025 16:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqimGtXH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C71D2D6E61
	for <netdev@vger.kernel.org>; Mon,  6 Oct 2025 16:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759767872; cv=none; b=Bq2Z5s6Rw4iDBf5r2rxy9mAFArzO4phsjhDuWwAFwPHARN3bQJj/C4XUFw8z0e0NJ5JJ0wSOYhVmUh4Cz7m6IUwyr3GG+S7Ou8KmIF+eHcE/Cno+d+UYqHQKvp+5As4yOq24qn/iQFZXkE5tt9nmVd6Uj06ad7p49CeKY8wmaw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759767872; c=relaxed/simple;
	bh=wzSI+3YV5h043Yiw4KDOsFqmPFSpeSzfbDx3HQrwZTw=;
	h=Content-Type:From:To:Subject:Message-ID:Date:MIME-Version; b=SK9pBLTLBKOOXkIkdjSVIPIo61sdb+pRYfw/3jO5m6sm5LjowNyG/kmbKnFqB96F2L/MU2rVclUDhzCtghMOU9cNGbkEGC4BiB8Aj0/ATCzltRZMz5TGsXiRJr4zw9xKxwDy5GtAFaYER4xUjMKHDLMFtjOxMmoowvw3sk7qML8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QqimGtXH; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-27edcbcd158so66808935ad.3
        for <netdev@vger.kernel.org>; Mon, 06 Oct 2025 09:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759767870; x=1760372670; darn=vger.kernel.org;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :reply-to:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wzSI+3YV5h043Yiw4KDOsFqmPFSpeSzfbDx3HQrwZTw=;
        b=QqimGtXHzEgUrSm8QokBmVVqBHTD3W+qA7p0mrQpfcg2VmHcPkjORFFykjh314SmyH
         AiC5LDanGCRwrtUuoqh33+UwaIGQmFMdOeGXa7BzGZGRzJeIUyMB8F+nhPlroz8bsDH7
         Q2dYI4q0WVMAQ5oTBdNcBD+ucL9f9IPrOjBBtW8/X0gJLYpXyPQAhQ+DVrwaLc62JoHG
         xfIRoVdM8fKIARVUiMqtir/M6XcpAroidpFBmjY0aYScV/7xsmqBgPnE0NPQo4dwXqGd
         IMu3of06wmlfoe6i7eGvPYb6D2t5N9GpSL929P8jQ+plqUqmrzlLu9KbGgzAYid5qy3O
         pP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759767871; x=1760372671;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :reply-to:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzSI+3YV5h043Yiw4KDOsFqmPFSpeSzfbDx3HQrwZTw=;
        b=h9OrW7FnzntdBFjAfoo8AMdaFMJyrasBALX6F5iZhK+mOj1wOQBOeMfKypB22e9MSH
         Hvzbd2b+vJvqWF+GpkTw0zNBxwUaErvVzKOGdL+VDrVLqdlCEyMZVjT76ZnvJEd4KQD5
         QVJUWCPHx31C4j0cczj8Oom/3XemYdfb9Z4NYtIVRy2UcEkJ8V/Hsuhm8Sb+d9eDPRbk
         LOryyWmA07SUYcv2PmiEbG5B9BMFetADj6pVb1F4VC9zVTBwTpVJpUBwOZgpdPwpL4sF
         JWCh5wR4TWEac3IeTrvsyyf6X0m+9W7trFTl+JKT5LDaCJZs0o6PlXXH4yYagMR7F67d
         taZw==
X-Gm-Message-State: AOJu0Yyl2Omambk13tjk42XQai3ydSNcqEzap+k1LnOgUFREhkN2p7Ab
	fqMx6088x2U2rolCZYwhDsCUT0oZMlYZJgqifJ9ZnxO9jP0o+zV2fFj0rO3Z0POd
X-Gm-Gg: ASbGncuVKsPzCGx7oBBjAVs7zlbHYnwQeGLC0jtfTWxOTFDjn7VooDPyVWKgQLe8YHw
	V6ylROC1Bl0g4tT7prrjA0y2tPl/BtIySjwYYypkHfRyfF+fN/GXIEDRKVGz4aZJoXHC7Sxkq5P
	r8g+jMH4Z86gQZM+ieMaSrR0d1ENpzrTYcM2rTPnvU/JlrnwQq6nhypSMLo5NK01VWQ3IvXoxdp
	V94HghiG0xHT76cZg4i4zHgld6HP+OoE3vDkIL9GYPFClyTsXBsA4YiV5UOlona+WbdE8uhmHff
	trCIPvYmeUUXeWzR5bpTAquLoUoX7/aieO5kqbCFFRTm52Kk4dP0CIWJOX2JRfpaxrJ4DUj0xj4
	R0JWHiqqlJ0kmMcabtH1EQA1jxHJIW9RFWJeHrLvsT8WspWuCl9gN+Sccn+Kvp3bK4jJ3A7JHkQ
	Via88ESCS5PBxfYpg=
X-Google-Smtp-Source: AGHT+IHV6L9XyEodlz+6OZBhPJUvSvK88VN38G38fmYwCCU1dwgzTAVXtUSmdhFtuQKRbrac6zSUVg==
X-Received: by 2002:a17:902:da8b:b0:269:a23e:9fd7 with SMTP id d9443c01a7336-28e9a56661bmr162803515ad.26.1759767870484;
        Mon, 06 Oct 2025 09:24:30 -0700 (PDT)
Received: from [127.0.0.1] ([154.80.22.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1ef43fsm137794075ad.122.2025.10.06.09.24.27
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 09:24:29 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: Bryan Kyler <bowenyu59@gmail.com>
To: netdev@vger.kernel.org
Reply-To: chrismorgance@gmail.com
Subject: Estimating & Take-Offs
Message-ID: <b73d96e0-433a-c171-3e93-cb9efef2d2e4@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Oct 2025 16:24:26 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello,

We are an estimation company. We provide estimating/takeoff =
services to GC and subcontractors.

We do estimates of all types of =
construction projects.

Send me the plans for a quote if you have any job =
for us. You may ask for a sample.

Regards,
Bryan Kyler
Estimation Department
City Estimating, LLC

