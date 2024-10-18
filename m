Return-Path: <netdev+bounces-136906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C7A9A3965
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 11:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA42A1F23C57
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 09:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF2618FDB2;
	Fri, 18 Oct 2024 09:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5zvoOLU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EFD18452C
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 09:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729242398; cv=none; b=nmQcemHDW+6v308JUOPDDT0EzBNPunXBRbxHNLIHpUP+LHxDmsXNgfTcbS+5MURWwkHE+wt6oYLwdeYsyJWscZLq9TfexIhFji3QbMvNorRysiK5/LU9T/yVTB/qQTtntrIkX0fox7hgvK2fyGSp3y1YkwS5KJFDfrDU5i1L97Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729242398; c=relaxed/simple;
	bh=J+r/BMBtfh6gt/dR32KIaGgKthUdGWIzWv17Th3MylE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MlQfy1FuHXyRNpUQ/Fstvz4e+GY3dKtABLP2E/lKNCa96sqxYj2tv05eh3msp8cHBAdppQ7DUr9pXmQ8cParERTKnHrYIQGQIN65/XV4mJGB6uViFHzNTAz7UI/+jNgKOFrKjwLYzutdtrffbPXb0G4muo4lQFCaOd4ajt6UcYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5zvoOLU; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43159c9f617so15265155e9.2
        for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 02:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729242394; x=1729847194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M9JEg3A6RW9P34jmmbyX7SQDzJf+yXqAeoouz7WpP9w=;
        b=A5zvoOLUujN6LIV0iLZhT4Z8KQYIAfZ87oH9nsGpkrAL3XCPD8yncbxJ5PCZlCqsVn
         HUJd/+Thb4V5jZvr4ERoqg2dXZAE/yLcqQhGbQDovh79SRs3WFuSuRRSOnS6hHW2Mk6G
         I5t6wjKOzEHBPp/1Feorgx7LavH8VbcraWGxQSmUgznMYsOtkWMP1q+KN3DQlUt7LrLa
         a+gKWt8KzR9P3H01Xi4+NuU/MvfZI+h5de49qX9YO7H5sEmNX4v+YIAw7cgyN/v4d9C1
         4sgMjUMdYKy93RRzlsupSyM9rVTXErAGBEEiYpnCM08+t8davUTMG81n+TVvHDRe27IG
         WCrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729242394; x=1729847194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M9JEg3A6RW9P34jmmbyX7SQDzJf+yXqAeoouz7WpP9w=;
        b=Fr/x7cwaK5XT/SluXtaanyaDnfRbf+ek+OqtcIzqKvyrRVLeqjGlYeRVoSHflLBQYS
         fdw62xAfETItMMXhLx/U5//+bq1b7aHC3hRAlNLRquQKlB70ng6jcspPuHIntOf952UC
         Qy9Ts/uvQVdM9bOu+2qocxFlerHgKXPma9Hrz+gO/UjjiCaMp71VxLqdrewJAp46xXNW
         nZXkEXHmQRlk7CZRJrbEc58hupE2jD0PtYKMewY/z6whGNfotvyxJms1/hFUqoFXXyl7
         ePf9CgwNKOY/siFeBIqPiN7rPgQXoox8gEj/04tckljtvwicaNQWRRC5qqwJRyCa+8Gg
         qnEg==
X-Gm-Message-State: AOJu0YzWYmaZ95eWSENimeMSBQYAGGnrzfMEuxAu2RU2oeSPdVcfUOpJ
	jPxIjiPn1fHdf3V5XklAlwOiHKIze9DZtIm94yRL1iUJUw2r9Ei6QAgaYw==
X-Google-Smtp-Source: AGHT+IFzQKuhvIiLktdOgmUu1ANctgXIZ8tQq8pt0FKw+NFt/2iQoRoruGK4NVEHqQYBh8BFSkXFEw==
X-Received: by 2002:a05:600c:1c9b:b0:42c:a6da:a149 with SMTP id 5b1f17b1804b1-4316168988fmr11923345e9.25.1729242394214;
        Fri, 18 Oct 2024 02:06:34 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:8040:ab28:8276:f527])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43160e4fe80sm18011405e9.46.2024.10.18.02.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 02:06:33 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Kory Maincent <kory.maincent@bootlin.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1] netlink: specs: Add missing bitset attrs to ethtool spec
Date: Fri, 18 Oct 2024 10:06:30 +0100
Message-ID: <20241018090630.22212-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are a couple of attributes missing from the 'bitset' attribute-set
in the ethtool netlink spec. Add them to the spec.

Reported-by: Kory Maincent <kory.maincent@bootlin.com>
Closes: https://lore.kernel.org/netdev/20241017180551.1259bf5c@kmaincent-XPS-13-7390/
Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/netlink/specs/ethtool.yaml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 6a050d755b9c..f6c5d8214c7e 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -96,7 +96,12 @@ attribute-sets:
         name: bits
         type: nest
         nested-attributes: bitset-bits
-
+      -
+        name: value
+        type: binary
+      -
+        name: mask
+        type: binary
   -
     name: string
     attributes:
-- 
2.47.0


