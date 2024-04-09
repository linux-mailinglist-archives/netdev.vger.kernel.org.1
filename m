Return-Path: <netdev+bounces-86273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F362289E4B5
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 22:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93AF71F23213
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 20:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6345158861;
	Tue,  9 Apr 2024 20:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="B24348M/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5094538DC9
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 20:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712696021; cv=none; b=ivMSY4T3eCkhpWup3KexuycqCX9xi5u7KshsgDW5Aqt/m4XWGUytu1rEcd+tCL7ZKsqnHQQHqZnXFQV56r0baT5VzNDb82rid+80gI3MSy+SX2C7+RXQ/kJ/Qi65/EjbMROHF5j++B/tQZDloccwcI/Zt11IVsOwtQAB1sYetpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712696021; c=relaxed/simple;
	bh=+ZK6BDpDzYocSVlMPON5u26LhnESeioKNtZjljPu2Vs=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=S7UzAIhUcRrQM5NBovI95oVq4HMaXuRqW497g0lt6Rv2R3NI5He9Q+4o6p320GhfwM/6y71MiruBJs0HnhTOVQkDjGUJrTppdTl2V4Ggw1C2dCss3/t37n/tBKHIL/jnTOzeLXTm5TTyhuj5nzXyFHdIAu4wr0c83ldZLg8RMa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=B24348M/; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 676433F19A
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 20:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1712696017;
	bh=EJ+HKk9Bo4Vt82jOzdBeHEs05+j74HpwAzSSP87YFvw=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=B24348M/ZRgmdsPJD5HuoY18dgvpU5PQkUrYyMgcFfcUv6eHfLi91B+4ExGyZBfSz
	 CqM0PttTYyAOt/FbS4jB0UFFTg+c7LT1kcGQcrD91iWs9U6TKz/nck+sAS+z8MC0xt
	 ukPw1UJHuUeHWh4OAZ8TPzCXHmeKF3yhaCF2dgjM10x0sqs3MTnBWyqaAGBIjYiRKu
	 bob2+v8EPMtZIkuO4oVFKPXmGZvbVhCxAfsREnNrSSjEIBa66SbkUmpF3pX6Np0bIU
	 XyDY0zK75+NegJqyrhmob41x1b46O+09uiSkqxj7itM8kEObAYA8MfYp1eMWiaeGtR
	 Y3TBOSZXTBpig==
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6ed34f8b3c8so1830665b3a.1
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 13:53:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712696016; x=1713300816;
        h=message-id:date:content-transfer-encoding:mime-version:comments
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EJ+HKk9Bo4Vt82jOzdBeHEs05+j74HpwAzSSP87YFvw=;
        b=CrpaWi63zvE4byiFxWMPOLM1nnPtWgPqUfEgHx3YqnYPblcX+HR/wq6wtWFH+CwtEB
         sgZQ7y+zfNYUcwJNkTz/+xTaPDK1G/wXwy8r0YJssayy+Nrm1OSlCCDgadyGrWSuIoSJ
         I6zaXvcKQkVQsTbgTjXScrjaGzm5PlskQCj38YEUc7w6QxGSugY2FpnLpwMa/TvW/ws+
         aKtdHNv7rpU6p9dHqH9sw9BW9ZV1yrtKAao0lmqu5qFSXWHIhmiBn5hFXp1qsSv/sn+Y
         BpSHsZpjuOTsvJgeFJD5IfjfrJ8ZmvVhgub0uFPSRDJ9FnUCsWeGpCodvc+E1BZcryBL
         sczg==
X-Forwarded-Encrypted: i=1; AJvYcCVkQVMdDo3V0Wnj3PGQSf4omizVlqcGk/7OAXnQ7xysVnI5HSzSSJ3SGkcnn+z/a/thBoPlgvlQTCTapbyu9V1jq5/uWjNH
X-Gm-Message-State: AOJu0YzKs1AZJs+47XVih0H3zko54AU4D7rmNA51YjpCD3z7cH22/tco
	hHEE7FwIxC6iOE3tmUfpiY09eVQo+TTNSWC0Qjb4A6l+Ec4nocphw7ODHmiKpH3oxokJ8dwxgnm
	3zBIeLxPwWT/j0/0HxHp2JGf8SUI5z7QcXNT1Jb4vCyqRfAmBXU57iy2ylGjKCPGZDZVneQ==
X-Received: by 2002:a05:6a21:6d89:b0:1a7:47b1:e8e2 with SMTP id wl9-20020a056a216d8900b001a747b1e8e2mr1200771pzb.9.1712696015844;
        Tue, 09 Apr 2024 13:53:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6OeCdchdkFd7XezQq8GET4N961DHEuYaM1VglblFz+o1eJU/psF271D3liB8WjJFG+4ALHA==
X-Received: by 2002:a05:6a21:6d89:b0:1a7:47b1:e8e2 with SMTP id wl9-20020a056a216d8900b001a747b1e8e2mr1200742pzb.9.1712696015191;
        Tue, 09 Apr 2024 13:53:35 -0700 (PDT)
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id l3-20020a17090ac58300b002a46a6ab205sm26408pjt.5.2024.04.09.13.53.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2024 13:53:34 -0700 (PDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 7DFDF604B6; Tue,  9 Apr 2024 13:53:34 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 76AB09FA74;
	Tue,  9 Apr 2024 13:53:34 -0700 (PDT)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: Eric Dumazet <edumazet@google.com>
cc: "David S . Miller" <davem@davemloft.net>,
    Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
    Andy Gospodarek <andy@greyhouse.net>, netdev@vger.kernel.org,
    eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 3/3] bonding: no longer use RTNL in bonding_show_queue_id()
In-reply-to: <CANn89i+qQ0zk4+jua1oiTNz6wqj2r1LTbp+W+d5eUaK38U8THA@mail.gmail.com>
References: <20240408190437.2214473-1-edumazet@google.com> <20240408190437.2214473-4-edumazet@google.com> <17498.1712695173@famine> <CANn89i+qQ0zk4+jua1oiTNz6wqj2r1LTbp+W+d5eUaK38U8THA@mail.gmail.com>
Comments: In-reply-to Eric Dumazet <edumazet@google.com>
   message dated "Tue, 09 Apr 2024 22:47:38 +0200."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Apr 2024 13:53:34 -0700
Message-ID: <18657.1712696014@famine>

Eric Dumazet <edumazet@google.com> wrote:

>On Tue, Apr 9, 2024 at 10:39=E2=80=AFPM Jay Vosburgh <jay.vosburgh@canonic=
al.com> wrote:
>>
>> Eric Dumazet <edumazet@google.com> wrote:
>>
>> >Annotate lockless reads of slave->queue_id.
>> >
>> >Annotate writes of slave->queue_id.
>> >
>> >Switch bonding_show_queue_id() to rcu_read_lock()
>> >and bond_for_each_slave_rcu().
>>
>>         This is combining two logical changes into one patch, isn't it?
>> The annotation change isn't part of what's stated in the Subject.
>
>The annotations are really part of this change, otherwise KCSAN might
>find races.

	Works for me.

Acked-by: Jay Vosburgh <jay.vosburgh@canonical.com>

	-J

---
	-Jay Vosburgh, jay.vosburgh@canonical.com

