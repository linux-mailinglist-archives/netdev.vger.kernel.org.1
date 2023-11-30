Return-Path: <netdev+bounces-52561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 729A77FF36B
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 16:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3A881C20DF8
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 15:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D15D524A9;
	Thu, 30 Nov 2023 15:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dwGBUgOE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0B310EA
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 07:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701357638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dEqkJxwjlfqEUZLoeifhFNRmLYsQ9sgPgHYM3n7xUho=;
	b=dwGBUgOEXqOlx8mjo/1zY3i73YlKDELtQEAvZ+eAv8aqAqAcz1k+YsYRbM7aB6IBVrtxtP
	OAz44eD/vQn0BYpKngVndkvzVpWjKqBqrKD3tVI0ByTF9uwUJH95U/akl+kKlPywP++j2A
	S6UK5JnU6lUfMYMU6NM3PT7coDFmYRY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-9hjVX9dXMGy6-2KbG-d8lQ-1; Thu, 30 Nov 2023 10:20:37 -0500
X-MC-Unique: 9hjVX9dXMGy6-2KbG-d8lQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40b371a69f9so1499285e9.1
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 07:20:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701357636; x=1701962436;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dEqkJxwjlfqEUZLoeifhFNRmLYsQ9sgPgHYM3n7xUho=;
        b=jGurex/5T8WN2nJGamZQQk+Deuq9Q+x/fx/+uMBoxuqYwFr9KLhz+5lntNiSZqS2uR
         6CWv5ihpANbAGnw7pMYKSqXeHzBWByEGgsv6NJrzq3BERmDkJp3LG2MkVgYh+UQBVn6D
         eYiaQhch6R2C3z3uRKr7SysMGOtyKyqQIuUunijyyFDEWGxOfB5LLSpeZUPV/LaLBzHS
         RbhDhcuflJ4W63BujhTqF25ILCXCLRVf2npuYXRGKXOUAIrMKXzkv8Qz04vLZnYOqpf7
         leclF66uA4rwvcTE6visz4bhri16n1Ii09E/FB6laeRx+GBO3wLIWYy+zY6TzWGu1T+m
         35Sw==
X-Gm-Message-State: AOJu0YzTpBuB/fYB/4t9G9mzjCHbpzSrBM3eq8SZtV1bhuGVtong9Dd6
	h0OoL0vCWsiD6O03PsmSd9/xkfrUYmnX/yFsS33ksQNSa5wcnnE85mNGSoO0G7VZAIuIjXzdbux
	xMBginBTI4W0wHFT/
X-Received: by 2002:a05:600c:8512:b0:405:358c:ba75 with SMTP id gw18-20020a05600c851200b00405358cba75mr15223897wmb.0.1701357636290;
        Thu, 30 Nov 2023 07:20:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmWmZDOiZtkqddOsdMjnFnx0anMvXkNnD8AcLel/BSwwmSEX8SLaio0xywMh1dMKaV6S35xQ==
X-Received: by 2002:a05:600c:8512:b0:405:358c:ba75 with SMTP id gw18-20020a05600c851200b00405358cba75mr15223881wmb.0.1701357635879;
        Thu, 30 Nov 2023 07:20:35 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-118-234.dyn.eolo.it. [146.241.118.234])
        by smtp.gmail.com with ESMTPSA id u2-20020a05600c138200b00405d9a950a2sm6036725wmf.28.2023.11.30.07.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 07:20:35 -0800 (PST)
Message-ID: <182382de40ab8f129829ceb3fa3f71608bfa65fb.camel@redhat.com>
Subject: Re: [GIT PULL] Networking for v6.7-rc4
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 30 Nov 2023 16:20:34 +0100
In-Reply-To: <20231130125638.726279-1-pabeni@redhat.com>
References: <20231130125638.726279-1-pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-11-30 at 13:56 +0100, Paolo Abeni wrote:
> We just received a report regarding the WiFi/debugfs fixes below possibly
> causing some dmesg noise - trying to register multiple times the same ent=
ry.

Jakub noted that such report is on a kernel that predates the changes
in this PR, so you can ignore the above.

Sorry for the noise,

Paolo


