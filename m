Return-Path: <netdev+bounces-155394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41616A02254
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 10:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C92E83A2B12
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 09:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B24159596;
	Mon,  6 Jan 2025 09:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mA05LC6h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B53B676
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 09:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736157459; cv=none; b=gb9EAbvCOfyHxMVgYcuZXnp80WLUph7UpxEsTXok9Zd8aQ+I+4qeUzO57QolT0IqCR9FoxJTGX2OQoDvHR1RUiEdNtR7rJwd5BxkVCEWhVD5oZOC6L8tSgWnTTdtjJ2BvHxt1vY0M8nbT4v6cMF/suRU75nICae03PHI/H2vCDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736157459; c=relaxed/simple;
	bh=+QZbl/ClBjscb0xGLKHvgjUuxy3PaNlX955erv2rUew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qdP6JRd0sDYjRCfq3KPlZfM8JwIEftvhHGn+xlAaQkmzpIUAyo6znn8ZMM3RXBhERaaNZcD0So9g5MlltzZugIkB+GYMoHkyEw8k3U05QR8NRBxj5vIGtkCWpsJEE41NJ2Pb6+mjC+hfDqpBRgTA0/0UKYak/5vNxjxEXJW8S8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mA05LC6h; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d0ac27b412so19260925a12.1
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 01:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736157456; x=1736762256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+QZbl/ClBjscb0xGLKHvgjUuxy3PaNlX955erv2rUew=;
        b=mA05LC6hnyXuDPtOFmdY9iWr6jWkXn3XLMAladTEbeenrfJ7cwLykUA3uhi8D87hQB
         voqWths2nw1fOydlBJnnggflhMn8uftEie/TJqAnGJVjs9Qmkh8TkjJOH8+CENdoM+cu
         GVVO/U+bjCo63ZmbLWS3qoESL4m6du9H9AZFj4nReSnwl7ntfyuFlxWFRNe1BBP9LZQr
         DpTkJyxA5Nmee4OWHTzpdI+4z5J71PVZcV1+n/UpOLtwzukFF7h40XtJkG5aLVc6NjEP
         BgNHDBUchRFHJmFdKR0dCdXaE6ZugdneEL8WapFu+wBFCQaD1YPxYv9iaNYAoPfIPiQZ
         0cJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736157456; x=1736762256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+QZbl/ClBjscb0xGLKHvgjUuxy3PaNlX955erv2rUew=;
        b=KqY9sa/ooZNxdEgX5ZUWtTFdVzsFKVzysf/WIzkViMGRrxvBYBrh13REEg3CjHz9qm
         B6tkYyDhvDqBDGGZi1UppH37Tb/zLnboFFKR5tXqiAQTuwGWAvL84qzFPUcmwzy48NK9
         eqpIQBTL6QzEFKW7HAT3e8vgdVILEo+V2ieLRVK/80i7NbbbGki8E2zl6MUT6uD7bEVb
         PgDwairQFGUFWl7tmitJNPgKBaypNihzXNdJi1Uln15R0rZ3znkqyGJF2xNO5t/E2jjX
         Mp4qp0QgsZdbj4HKhatkCPUMPfq8iPdd1935L/tQzVA4ArEy68W62p/JWtoeD7rkUDSX
         uKHg==
X-Forwarded-Encrypted: i=1; AJvYcCVNA1A6uX5kzpSyvZEIRU+hJhOKTCojDhUH8fJs9WWtmsnCCTG1YBMCFXaNMAwM1nMl5KcL/tQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIYVcTU3TA1WCdwnOF5lNcbwdH9CBUn6CQGJCfFXA726jw6L0d
	wRLefG/5hmwK4opQ4sarEt7OdC73n29CMV3JJyAI8HUZ4b4SQlTS7xCivimobvDfdhujIFtiig1
	tzHGtfyDzjBNJIJ9QmbmkJ05ox68SQS9Lzolo
X-Gm-Gg: ASbGnctk3wTAKjTpZmOEDn7WMLUB80PWAMxib1L/Gj/CoD74LstLJqtDBss0NXnAjDF
	N3iWBRqEEoxuvR3fwPrzrzlRVTfNSZaM2HU7MUQ==
X-Google-Smtp-Source: AGHT+IHp7oMvfUrQtzDao4rPWmJsYNWKBbPiIV/2fTJDafd72wUTJpy74H5qqVyTuO5nkwGyVgc5k0iHX/ZKPq+W0HU=
X-Received: by 2002:a05:6402:524d:b0:5d2:723c:a57e with SMTP id
 4fb4d7f45d1cf-5d81ddacfeemr54564734a12.16.1736157456346; Mon, 06 Jan 2025
 01:57:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250103185954.1236510-1-kuba@kernel.org> <20250103185954.1236510-6-kuba@kernel.org>
In-Reply-To: <20250103185954.1236510-6-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 6 Jan 2025 10:57:24 +0100
Message-ID: <CANn89iKvEzKv60usS==86wjxV0ZBrs5V5KL9Doc1RwOOchUo+w@mail.gmail.com>
Subject: Re: [PATCH net-next 5/8] netdevsim: add queue alloc/free helpers
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	dw@davidwei.uk, almasrymina@google.com, jdamato@fastly.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 3, 2025 at 8:00=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> We'll need the code to allocate and free queues in the queue management
> API, factor it out.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

