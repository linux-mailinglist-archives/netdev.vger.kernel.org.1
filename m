Return-Path: <netdev+bounces-51376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB5D7FA673
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 17:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25BDF2819F0
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 16:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BBC36B0A;
	Mon, 27 Nov 2023 16:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJNthJGn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2414DEA
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 08:32:48 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6c48fad2f6dso534090b3a.0
        for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 08:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701102767; x=1701707567; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W9TTKcIk+mWP67gxtJMKGszql8gYTWQBjGYcJE+4pRw=;
        b=OJNthJGnux8tyNc37IRO6rjTT6la76izA+tHpP8E39Z6UhFgwxKDh24TfxipHggYm1
         IhEFOAMdORQ74adGJP9RPnonaxyk3K5GqKQ6KgI/lHxENVyIb0DR5vV1axe0tWXOzwN/
         Tt6/PICyr2lkMs1SnMBnq0YZcLEE0mROi7sT3RxRZP+2YVkBaYSHe/hP1g3VR2+GD8wB
         Y3QGIrQwhfhRh1iUpztaGfvt7O367hXuTexbqskAt2vbdT8WzjKSlDg4wdsEJ8ONkB26
         /NdZ/rkGYyDXlQzFBfjlNARRtJ558wiVUWXgqlN11KJceGhe7N6Ly1ArNQ7kOAyDlM5H
         G8JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701102767; x=1701707567;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W9TTKcIk+mWP67gxtJMKGszql8gYTWQBjGYcJE+4pRw=;
        b=b0sRSII2bfOKoENXMG/A3Ov2SEXkj0UX30I7+ZMelvX7s49YDlcg/mSsFlFC5kzZvw
         DnrCdPA8HyOW6yZsmbureMpI7o6gHEvWRVSeDy29JwshVyclp2LZtm7k6LwjXDR8NhtJ
         G9Pn7QYqz+tAv4mb9dduSSh8tcJA2xNsDGSzzvhMIOAVpRo8PsexrNpfeB8vjQJ/H4Ub
         bN/4cs5sAD9r+HzG9CiM1Xt4iG7c8jDdBZxf/BBoPfR6HryHGix19Nom6ccxxQYy6aJN
         UAsSb0ttxGKwDx42Fd5JoBepXCK6ilLTzQkSSf5q6PIS0XPkt00ruVgyNmw6f1GPRaR5
         9cpQ==
X-Gm-Message-State: AOJu0Yz3H4Urlu6phZp8kEBs9DDfCKygXDRWWCOxeJb/7kTnh7gYySau
	nrUN/W5QcXSooZl6ve8Dyoz2p4szP7k=
X-Google-Smtp-Source: AGHT+IEuzs8GSrOoiPaqJItwlehKEwx8jGVg/C9ceqGL1IH72V6abrfu5Ogd1I3ePH2CJCrO6J0ung==
X-Received: by 2002:a05:6a21:a598:b0:18b:d26a:375c with SMTP id gd24-20020a056a21a59800b0018bd26a375cmr17965686pzc.1.1701102767305;
        Mon, 27 Nov 2023 08:32:47 -0800 (PST)
Received: from DESKTOP-6F6Q0LF (static-host119-30-85-97.link.net.pk. [119.30.85.97])
        by smtp.gmail.com with ESMTPSA id b2-20020a056a00114200b0068fece22469sm7327030pfm.4.2023.11.27.08.32.45
        for <netdev@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 27 Nov 2023 08:32:46 -0800 (PST)
Message-ID: <6564c4ae.050a0220.c1212.189a@mx.google.com>
Date: Mon, 27 Nov 2023 08:32:46 -0800 (PST)
X-Google-Original-Date: 27 Nov 2023 11:32:45 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: koltencreed417@gmail.com
To: netdev@vger.kernel.org
Subject: Building Estimates
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
X-Spam-Level: ***

Hi,=0D=0A=0D=0AWe provide estimation & quantities takeoff service=
s. We are providing 98-100 accuracy in our estimates and take-off=
s. Please tell us if you need any estimating services regarding y=
our projects.=0D=0A=0D=0ASend over the plans and mention the exac=
t scope of work and shortly we will get back with a proposal on w=
hich our charges and turnaround time will be mentioned=0D=0A=0D=0A=
You may ask for sample estimates and take-offs. Thanks.=0D=0A=0D=0A=
Kind Regards=0D=0AKolten Creed		=0D=0ADreamland Estimation, LLC


